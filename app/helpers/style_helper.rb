module Merb
  module MerbInterface
    module StyleHelper
      
      def hex_add(number1, number2)
        (number1.to_i(base=16) + number2.to_i(base=16)).to_s(base=16)
      end

      def hex_subtract(number1, number2)
        result = (number1.to_i(base=16) - number2.to_i(base=16)).to_s(base=16)
        result = '000000' if result == '0'
        result
      end

      def round_corners(options={})
        options[:amount] ||= 0.25
        if options[:edge] == 'top'
          properties = %(border-radius-topleft: #{options[:amount]}em;)
          properties << %(\r  )
          properties << %(border-radius-topright: #{options[:amount]}em;)
          properties << %(\r  )
        else
          properties = %(border-radius: #{options[:amount]}em;)
          properties << %(\r  )
        end
        # Remove the following after Safari supports border-radius officially
        if mi_browser == 'webkit'
          if options[:edge] == 'top'
            properties << %(-webkit-border-top-left-radius: #{options[:amount]}em;)
            properties << %(\r  )
            properties << %(-webkit-border-top-right-radius: #{options[:amount]}em;)
          else
            properties << %(-webkit-border-radius: #{options[:amount]}em;)
          end
        # Remove the following after FireFox supports border-radius officially
        elsif mi_browser == 'gecko'
          if options[:edge] == 'top'
            properties << %(-moz-border-radius-topleft: #{options[:amount]}em;)
            properties << %(\r  )
            properties << %(-moz-border-radius-topright: #{options[:amount]}em;)
          else
            properties << %(-moz-border-radius: #{options[:amount]}em;)
          end
        # Force Internet Explorer to render buttons without extra padding
        elsif mi_browser == 'ie'
          properties << %(overflow: visible;)
          properties << %(\r  )
          properties << %(width: auto;)
        end
        properties
      end

    end
  end
end