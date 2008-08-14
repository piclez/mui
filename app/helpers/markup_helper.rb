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

      def mi_button(text='', options={}, &block)
        attributes_button={}
        attributes_button[:class] = 'mi_button'
        attributes_button[:onclick] = %{location.href='#{options[:url]}'} if options[:url]
        attributes_button[:style] = %{width:#{options[:width]}em;} if options[:width]
        attributes_td={}
        attributes_td[:class] = 'mi_button_text'
        if block and text != ''
          %{<button #{attributes_button.to_xml_attributes}><table><tr><td>#{capture(&block)}</td><td #{attributes_td.to_xml_attributes}>#{text}</td></tr></table></button>}
        elsif block
          %{<button #{attributes_button.to_xml_attributes}>#{capture(&block)}</button>}
        else
          %{<button #{attributes_button.to_xml_attributes}>#{text}</button>}
        end
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
      
      def mi_column(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_column'
        attributes[:style] = %{width:#{(options[:width] * 100).to_i}%;} if options[:width]
        %{<td #{attributes.to_xml_attributes}>#{capture(&block)}</td>}
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

      def mi_link(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_link'
        attributes[:href] = options[:url] if options[:url]
        %{<a #{attributes.to_xml_attributes}>#{capture(&block)}</a>}
      end

      def mi_merb
        attributes={}
        attributes[:class] = 'mi_merb'
        attributes[:onclick] = %{location.href='http://merbivore.com/'}
        %{<div #{attributes.to_xml_attributes}></div>}
      end

      def mi_paragraph(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_paragraph'
        attributes[:class] << '_first' if options[:first] == true
        %{<p #{attributes.to_xml_attributes}>#{capture(&block)}</p>}
      end

      def mi_picture(file, options={})
        attributes={}
        attributes[:class] = 'mi_picture'
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
