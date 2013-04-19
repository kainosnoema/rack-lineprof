module Rack
  class Lineprof
    class Sample < Struct.new :line, :ms, :code, :level

      def format colorize = true
        formatted = if level == CONTEXT
          sprintf "           | % 3i  %s", line, code
        else
          sprintf "% 8.1fms | % 3i  %s", ms, line, code
        end

        return formatted unless colorize

        case level
        when CRITICAL
          color.red formatted
        when WARNING
          color.yellow formatted
        when NOMINAL
          color.white formatted
        else # CONTEXT
          color.intense_black formatted
        end
      end

      private

      def color
        Term::ANSIColor
      end

    end
  end
end
