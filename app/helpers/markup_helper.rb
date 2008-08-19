module Merb
  module MerbInterface
    module MarkupHelper

      def mi_assets(options={})
        options[:css] ||= true
        options[:js] ||= true
        assets = ''
        if options[:css] == true
          assets << %{<link type="text/css" charset="utf-8" href="#{url(:merb_interface_style)}" media="all" rel="Stylesheet"/>}
        end
        if options[:js] == true
          assets << %{<script type="text/javascript" src="#{url(:merb_interface_script)}"></script>}
        end
        assets
      end

      def mi_bar(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_bar'
        attributes[:class] << '_expanded' if options[:expanded] == true
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

      def mi_browser
        user_agent = request.user_agent.downcase
        if user_agent.include? 'webkit'
          'webkit'
        elsif user_agent.include? 'gecko'
          'gecko'
        elsif user_agent.include? 'msie'
          'msie'
        end
      end
      
      def mi_button(options={}, &block)        
        attributes={}
        attributes[:class] = 'mi_button'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        attributes[:onclick] = %{location.href='#{options[:url]}'} if options[:url]
        attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
        if options[:submit] == true
          attributes[:type] = 'submit'
        else
          attributes[:type] = 'button'
        end
        attributes[:value] = options[:text] if options[:text]
        if block
          html = %{<button #{attributes.to_xml_attributes}>}
          attributes_td={}
          attributes_td[:class] = 'mi_button_text'
          if options[:text]
            html << %{<table><tr><td>#{capture(&block)}</td><td #{attributes_td.to_xml_attributes}>#{options[:text]}</td></tr></table>}
          else
            html << capture(&block)
          end
          html << %{</button>}
        else
          html = %{<input #{attributes.to_xml_attributes}/>}
        end
      end

      def mi_column(options={}, &block)
        attributes={}
        attributes[:align] = options[:align] if options[:align]
        attributes[:class] = 'mi_column'
        attributes[:class] << '_right' if options[:align] == 'right'
        attributes[:style] = %{width:#{(options[:width] * 100).to_i}%;} if options[:width]
        %{<td #{attributes.to_xml_attributes}>#{capture(&block)}</td>}
      end

      def mi_field(text, options={})
        options[:type] ||= 'text'
        attributes_input={}
        attributes_input[:checked] = 'checked' if options[:selected] == true if options[:type] == 'checkbox'
        attributes_input[:class] = %{mi_field_#{options[:type]}}
        attributes_input[:id] = options[:id] if options[:id]
        attributes_input[:name] = options[:name] if options[:name]
        attributes_input[:type] = options[:type]
        attributes_input[:value] = options[:text] if options[:text]
        attributes_label={}
        attributes_label[:class] = 'mi_field_label'
        attributes_label[:class] << '_optional' if options[:optional] == true
        attributes_label[:for] = options[:id] if options[:id]
        attributes_span={}
        attributes_span[:class] ||= 'mi_field'
        attributes_span[:class] << ' mi_inline' if options[:inline] == true
        html = %{<span #{attributes_span.to_xml_attributes}>}
        if options[:type] == 'checkbox'
          html << %{<input #{attributes_input.to_xml_attributes}/> <label #{attributes_label.to_xml_attributes}>#{text}</label>}
        else
          html << %{<label #{attributes_label.to_xml_attributes}>#{text}</label><input #{attributes_input.to_xml_attributes}/>}
        end
        html << %{</span>}
      end

      def mi_image(file, options={})
        attributes={}
        attributes[:align] = options[:align] if options[:align]
        attributes[:class] = 'mi_image'
        attributes[:class] << '_margin' if options[:margin] != false
        attributes[:class] << '_border_radius' if options[:border_radius] == true
        attributes[:class] << ' mi_inline' if options[:inline] == true
        attributes[:src] = '/images/nil.png'
        attributes[:style] = %{background-image: url('#{file}');}
        attributes[:style] << %{height: #{options[:height]}px;} if options[:height]
        attributes[:style] << %{width: #{options[:width]}px;} if options[:width]
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_link(text, options={}, &block)
        attributes={}
        attributes[:class] = 'mi_link'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        attributes[:href] = options[:url] if options[:url]
        if block
          content = capture(&block)
        else
          content = text
        end
        %{<a #{attributes.to_xml_attributes}>#{content}</a>}
      end

      def mi_paragraph(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_paragraph'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        %{<p #{attributes.to_xml_attributes}>#{capture(&block)}</p>}
      end

      def mi_photo(file, options={})
        attributes={}
        attributes[:class] = 'mi_photo'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        attributes[:src] ||= file
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_row(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_row'
        %{<table #{attributes.to_xml_attributes}><tr>#{capture(&block)}</tr></table>}
      end

      def mi_tab(options={})
        attributes={}
        attributes[:class] = 'mi_tab'
        if options[:controller] == controller_name || options[:selected] == true
          attributes[:type] = 'submit'
        else
          attributes[:onclick] = %{location.href='#{options[:url]}'} if options[:url]
          attributes[:type] = 'button'
        end
        attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
        attributes[:value] = options[:text] if options[:text]
        %{<input #{attributes.to_xml_attributes}/>}
      end

      def mi_title(text, options={})
        options[:size] ||= 1
        attributes={}
        attributes[:class] = 'mi_title'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        %{<h#{options[:size]} #{attributes.to_xml_attributes}>#{text}</h#{options[:size]}>}
      end

      def mi_tray(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_tray'
        attributes[:class] << ' mi_inline' if options[:inline] == true
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

    end
  end
end
