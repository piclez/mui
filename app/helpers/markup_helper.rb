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
        options[:type] ||= 'panel'
        attributes={}
        attributes[:class] = 'mi_bar'
        attributes[:class] << %{_#{options[:edge]}} if options[:edge]
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

      def mi_block(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_block'
        attributes[:class] << '_inline' if options[:inline] == true
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<span #{attributes.to_xml_attributes}>#{capture(&block)}</span>}
      end

      def mi_button(text, options={})
        attributes={}
        attributes[:class] = 'mi_button'
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        options[:type] ||= 'button'
        attributes[:type] = options[:type]
        %{<input #{attributes.to_xml_attributes} value="#{text}"/>}
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
      
      def mi_checkbox(text, options={})
        attributes_input={}
        attributes_input[:class] = 'mi_checkbox'
        attributes_input[:id] = options[:id]
        attributes_input[:checked] = 'checked' if options[:selected] == true
        attributes_input[:type] = 'checkbox'
        attributes_label={}
        attributes_label[:class] = 'mi_label'
        attributes_label[:for] = options[:id]
        %{<label #{attributes_label.to_xml_attributes}><input #{attributes_input.to_xml_attributes}/> #{text}</label>
        }
      end

      def mi_field(text, options={})
        options[:required] ||= true
        attributes_div={}
        attributes_div[:class] ||= 'mi_field_label'
        attributes_div[:class] << '_required' if options[:required] == true
        attributes_input={}
        attributes_input[:class] = 'mi_field'
        attributes_input[:id] = options[:id]
        attributes_input[:type] = 'text'
        attributes_input[:value] = options[:text] if options[:text]
        attributes_label={}
        attributes_label[:class] = 'mi_label'
        %{<label #{attributes_label.to_xml_attributes}><div #{attributes_div.to_xml_attributes}>#{text}</div><input #{attributes_input.to_xml_attributes}/></label>}
      end

      def mi_link(block, path='', options={})
        attributes={}
        attributes[:class] = 'mi_link'
        attributes[:href] ||= path
        %{<a #{attributes.to_xml_attributes}>#{block}</a>}
      end

      def mi_paragraph(options={}, &block)
        attributes={}
        attributes[:class] = 'mi'
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<p #{attributes.to_xml_attributes}>#{capture(&block)}</p>}
      end

      def mi_picture(file, options={})
        attributes={}
        attributes[:class] = 'mi_picture'
        attributes[:src] ||= file
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_tab(text, options={})
        attributes={}
        attributes[:class] = 'mi_tab'
        attributes[:class] << '_selected' if options[:selected] == true
        attributes[:id] = options[:id]
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<button #{attributes.to_xml_attributes}>#{text}</button>}
      end

      def mi_tray(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_tray'
        attributes[:style] = %{width:#{options[:width] * 100}%;} if options[:width]
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

    end
  end
end
