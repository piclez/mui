module Merb
  module MerbInterface
    module StyleHelper
      
      def border_radius(options={})
        options[:amount] ||= 0.5
        if mi_browser == 'gecko'
          property('-moz') do
            property('border') do
              if options[:corner] == 'top_left'
                property('topleft', :value => %{#{options[:amount]}em})
              elsif options[:edge] == 'left'
                property('radius') do
                  property('bottomleft', :value => %{#{options[:amount]}em})
                  property('topleft', :value => %{#{options[:amount]}em})
                end
              elsif options[:edge] == 'bottom'
                property('radius') do
                  property('bottomleft', :value => %{#{options[:amount]}em})
                  property('bottomright', :value => %{#{options[:amount]}em})
                end
              elsif options[:edge] == 'top'
                property('radius') do
                  property('topleft', :value => %{#{options[:amount]}em})
                  property('topright', :value => %{#{options[:amount]}em})
                end
              else
                property('radius', :value => %{#{options[:amount]}em})
              end
            end
          end
        elsif mi_browser == 'webkit'
          property('-webkit') do
            property('border') do
              if options[:corner] == 'top_left'
                property('top-left-radius', :value => %{#{options[:amount]}em})
              elsif options[:edge] == 'left'
                property('bottom-left-radius', :value => %{#{options[:amount]}em})
                property('top-left-radius', :value => %{#{options[:amount]}em})
              elsif options[:edge] == 'bottom'
                property('bottom') do
                  property('left-radius', :value => %{#{options[:amount]}em})
                  property('right-radius', :value => %{#{options[:amount]}em})
                end
              elsif options[:edge] == 'top'
                property('top') do
                  property('left-radius', :value => %{#{options[:amount]}em})
                  property('right-radius', :value => %{#{options[:amount]}em})
                end
              else
                property('radius', :value => %{#{options[:amount]}em})
              end
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