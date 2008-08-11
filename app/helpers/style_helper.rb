module Merb
  module MerbInterface
    module StyleHelper
      
      def border_radius_gecko(options={})
        options[:amount] ||= 0.5
        property('-moz') do
          property('border') do
            if options[:edge] == 'top'
              property('radius') do
                property('bottomleft', :value => %{#{options[:amount]}em})
                property('bottomright', :value => %{#{options[:amount]}em})
              end
            else
              property('radius', :value => %{#{options[:amount]}em})
            end
          end
        end
      end

      def border_radius_webkit(options={})
        options[:amount] ||= 0.5
        property('-webkit') do
          property('border') do
            if options[:edge] == 'top'
              property('bottom') do
                property('left-radius', :value => %{#{options[:amount]}em})
                property('right-radius', :value => %{#{options[:amount]}em})
              end
            else
              property('radius', :value => %{#{options[:amount]}em})
            end
          end
        end
      end

      def color(red,green,blue)
        %{rgb(#{decimal_to_rgb(red)}, #{decimal_to_rgb(green)}, #{decimal_to_rgb(blue)})}
      end
      
      def decimal_to_rgb(d)
        (d * 255).to_i
      end

      def property(property, options={})
        @parent ||= ''
        @child ||= ''
        if block_given?
          @child = nil
          @parent << %{#{property}-}
          yield
          @parent = nil
          @child
        elsif options[:value]
          @child << %{\r  #{@parent}#{property}: #{options[:value]};}
        end
      end
      
      def selector(selector)
        "#{selector} {#{yield}\r}\r"
      end

    end
  end
end