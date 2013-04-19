module Rack
  class Lineprof
    class Sample < Struct.new :ms, :calls, :line, :code, :level

      def format colorize = true
        formatted = if level == CONTEXT
          sprintf "               | % 3i  %s", line, code
        else
          sprintf "% 6.1fms %5i | % 3i  %s", ms, calls, line, code
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
