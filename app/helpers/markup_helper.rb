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
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

      def mi_block(options={}, &block)
        attributes={}
        attributes[:class] = 'mi_block'
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

      def mi_button(text, options={})
        attributes={}
        attributes[:class] = 'mi'
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
          'ie'
        end
      end

      def mi_label(text, options={})
        attributes={}
        attributes[:class] = 'mi'
        %{<label #{attributes.to_xml_attributes}>#{text}</label>}
      end

      def mi_link(block, path='', options={})
        attributes={}
        attributes[:class] = 'mi'
        attributes[:href] ||= path
        %{<a #{attributes.to_xml_attributes}>#{block}</a>}
      end

      def mi_paragraph(options={}, &block)
        attributes={}
        attributes[:class] = 'mi'
        %{<p #{attributes.to_xml_attributes}>#{capture(&block)}</p>}
      end

      def mi_picture(file, options={})
        attributes={}
        attributes[:class] = 'mi_picture'
        attributes[:src] ||= file
        %{<img #{attributes.to_xml_attributes} />}
      end

      def mi_tray(options={}, &block)
        options[:type] ||= 'outer'
        attributes={}
        attributes[:class] = %(mi_tray_#{options[:type]})
        %{<div #{attributes.to_xml_attributes}>#{capture(&block)}</div>}
      end

    end
  end
end
