module Rack
  class Lineprof
    class Source

      attr_reader :file_name, :raw_samples, :options

      def initialize file_name, raw_samples, options = {}
        @file_name, @raw_samples, @options = file_name, raw_samples, options
      end

      def format colorize = true
        return nil if samples.empty?

        formatted = file_name.sub(Dir.pwd + '/', '') + "\n"

        prev_line = samples.first.line - 1
        samples.each do |sample|
          if sample.line != prev_line + 1
            formatted << color.intense_black(' ' * 14 + '.' * 7) + "\n"
          end
          prev_line = sample.line

          formatted << sample.format
        end

        formatted
      end

      def samples
        @samples ||= begin
          parsed = []

          raw_samples.each_with_index do |sample, line|
            next if line == 0 # drop file info

            ms = sample[0] / 1000.0
            calls = sample[2]

            clocked = ms >= 0.2 # info
            near_clocked = (line-context..line+context).any? do |near|
              near = [1, near].max
              next unless raw_samples[near]
              (raw_samples[near][0] / 1000.0) >= 0.2 # info
            end

            next unless clocked or near_clocked

            threshold = thresholds.detect { |boundary, _| ms > boundary }
            level = threshold ? threshold.last : CONTEXT

            next unless code = source_lines[line - 1]
            parsed << Sample.new(ms, calls, line, code, level)
          end

          parsed
        end
      end

      def source_lines
        @source_lines ||= ::File.open(file_name, 'r').to_a
      end

      private

      def color
        Term::ANSIColor
      end

      def context
        options.fetch :context, 2
      end

      def thresholds
        @thresholds ||= {
          CRITICAL => 50,
          WARNING  => 5,
          NOMINAL  => 0.2
        }.merge(options.fetch :thresholds, {}).invert
      end

    end
  end
end
