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
        attributes[:class] << %{_#{options[:edge]}} if options[:edge]
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
      
      def mi_button(text='', options={}, &block)
        attributes_button={}
        attributes_button[:class] = 'mi_button'
        attributes_button[:onclick] = %{location.href='#{options[:url]}'} if options[:url]
        attributes_button[:style] = %{width:#{options[:width]}em;} if options[:width]
        if options[:submit] == true
          attributes_input={}
          attributes_input[:class] = 'mi_button_submit'
          attributes_input[:type] = 'submit'
          attributes_input[:value] = text
          html = %{<input #{attributes_input.to_xml_attributes}/>}
        else
          html = %{<button #{attributes_button.to_xml_attributes}>}
          if block and text != ''
            attributes_td={}
            attributes_td[:class] = 'mi_button_text'
            html << %{<table><tr><td>#{capture(&block)}</td><td #{attributes_td.to_xml_attributes}>#{text}</td></tr></table>}
          elsif block
            html << capture(&block)
          else
            attributes_span={}
            attributes_span[:class] = 'mi_button_text'
            html << %{<span #{attributes_span.to_xml_attributes}>#{text}</span>}
          end
          html << %{</button>}
        end
      end

      def mi_column(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_column'
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
        attributes[:height] = options[:height] if options[:height]
        if options[:border_radius] == true
          attributes[:class] << '_border_radius'
          attributes[:src] = '/images/nil.png'
          attributes[:style] = %{background-image: url('#{file}');}
        else
          attributes[:src] ||= file
        end
        attributes[:width] = options[:width] if options[:width]
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_link(text, options={}, &block)
        attributes={}
        attributes[:class] = 'mi_link'
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
        %{<p #{attributes.to_xml_attributes}>#{capture(&block)}</p>}
      end

      def mi_photo(file, options={})
        attributes={}
        attributes[:class] = 'mi_photo'
        attributes[:src] ||= file
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_row(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_row'
        %{<table #{attributes.to_xml_attributes}><tr>#{capture(&block)}</tr></table>}
      end

      def mi_tab(text, options={})
        attributes={}
        attributes[:class] = 'mi_tab'
        attributes[:id] = options[:id]
        attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
        if options[:controller] == controller_name || options[:selected] == true
          attributes[:class] << '_selected'
        else
          attributes[:onclick] = %{location.href='#{options[:url]}'} if options[:url]
        end
        %{<button #{attributes.to_xml_attributes}>#{text}</button>}
      end

      def mi_title(text, options={})
        options[:size] ||= 1
        attributes={}
        attributes[:class] = 'mi_title'
        %{<h#{options[:size]} #{attributes.to_xml_attributes}>#{text}</h#{options[:size]}>}
      end

      def mi_tray(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_tray'
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

    end
  end
end
