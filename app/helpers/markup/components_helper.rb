module Merb::MerbInterface::ComponentsHelper
  
  def mi_bar(options = {}, &block)
    element(:div, :class => %{mi_bar#{'_expanded' if options[:expanded] == true}}) do
      div = ''
      if options[:label]
        div << element(:span, :class => 'mi_bar_label') do
          options[:label]
        end
      end
      div << capture(&block) if block_given?
      div
    end
  end

  def mi_button(options = {}, &block)
    attributes = {}
    attributes[:class] = %{mi_button#{' mi_inline' if options[:inline] == true}}
    attributes[:class] << ' mi_dialog_close' if options[:dialog] == 'close'
    attributes[:class] << ' mi_dialog_open' if options[:dialog] == 'open'
    attributes[:id] = options[:url] if options[:url]
    attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
    attributes[:type] = options[:submit] == true ? 'submit' : 'button'
    if options[:dialog] == 'close'
      attributes[:value] = 'x'
    else
      attributes[:value] = options[:label] if options[:label]
    end
    if block_given?
      element(:button, attributes) do
        if options[:label]
          element(:table) do
            element(:tr) do
              tr = element(:td) do
                capture(&block)
              end
              tr << element(:td, :class => 'mi_button_text') do
                options[:label]
              end
              tr
            end
          end
        else
          capture(&block)
        end
      end
    else
      element(:input, attributes)
    end
  end

  def mi_column(options={}, &block)
    attributes={}
    attributes[:align] = options[:align] if options[:align]
    attributes[:class] = 'mi_column'
    attributes[:class] << '_right' if options[:align] == 'right'
    attributes[:style] = %{width:#{(options[:width] * 100).to_i}%;} if options[:width]
    element(:td, attributes) do
      capture(&block)
    end
  end

  def mi_image(file, options={})
    attributes={}
    attributes[:align] = options[:align] if options[:align]
    attributes[:class] = 'mi_image'
    attributes[:class] << '_margin' if options[:margin] != false
    if options[:height] && options[:width]
      attributes[:class] << '_border_radius' if options[:border_radius] == true
      attributes[:src] = '/images/nil.png'
      attributes[:style] = %{background-image: url('#{file}');}
      attributes[:style] << %{height: #{options[:height]}px;} if options[:height]
      attributes[:style] << %{width: #{options[:width]}px;} if options[:width]
    else
      attributes[:src] = file
    end
    attributes[:class] << ' mi_photo' if options[:photo] == true
    attributes[:class] << ' mi_inline' if options[:inline] == true
    element(:img, attributes)
  end

  def mi_link(content, options={}, &block)
    attributes={}
    attributes[:class] = 'mi_link'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    attributes[:href] = options[:url] if options[:url]
    content = capture(&block) if block_given?
    element(:a, attributes) do
      content
    end
  end

  def mi_paragraph(options={}, &block)
    attributes={}
    attributes[:class] = 'mi_paragraph'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    element(:p, attributes) do
      capture(&block) if block_given?
    end
  end

  def mi_row(options={}, &block)
    element(:table, :class => 'mi_row') do
      element(:tr) do
        capture(&block) if block_given?
      end
    end
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
    attributes[:value] = options[:label] if options[:label]
    element(:input, attributes)
  end

  def mi_title(text, options={})
    options[:size] ||= 1
    attributes={}
    attributes[:class] = 'mi_title'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    element(%{h#{options[:size]}}, attributes) do
      text
    end
  end

  def mi_tray(options={}, &block)
    attributes={}
    attributes[:class] = 'mi_tray'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    element(:div, attributes) do
      capture(&block) if block_given?
    end
  end

end

include Merb::MerbInterface::ComponentsHelper