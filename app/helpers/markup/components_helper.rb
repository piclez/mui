module Merb::MerbInterface::ComponentsHelper
  
  def mi_bar(options = {}, &block)
    content = ''
    content << tag(:span, options[:label], :class => 'mi_bar_label') if options[:label]
    content << capture(&block) if block_given?
    tag(:div, content, :class => %{mi_bar#{'_expanded' if options[:expanded] == true}})
  end

  def mi_button(options = {}, &block)
    attributes = {}
    attributes[:class] = %{mi_button#{' mi_inline' if options[:inline] == true}}
    attributes[:class] << ' mi_click'
    attributes[:class] << '_dialog_open' if options[:dialog] == 'open'
    attributes[:id] = options[:url] if options[:url]
    attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
    attributes[:type] = options[:submit] == true ? 'submit' : 'button'
    if options[:dialog] == 'close'
      attributes[:class] << '_dialog_close'
      attributes[:value] = 'x'
    else
      attributes[:value] = options[:label] if options[:label]
    end
    if block_given?
      if options[:label]
        content = tag(:table, tag(:tr, tag(:td, capture(&block)) + tag(:td, options[:label], :class => 'mi_button_text')))
      else
        content = capture(&block)
      end
      tag(:button, content, attributes)
    else
      self_closing_tag(:input, attributes)
    end
  end

  def mi_column(options={}, &block)
    attributes={}
    attributes[:align] = options[:align] if options[:align]
    attributes[:class] = 'mi_column'
    attributes[:class] << '_right' if options[:align] == 'right'
    attributes[:style] = %{width:#{(options[:width] * 100).to_i}%;} if options[:width]
    tag(:td, (capture(&block) if block_given?), attributes)
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
    self_closing_tag(:img, attributes)
  end

  def mi_link(content, options={}, &block)
    attributes = {}
    attributes[:class] = 'mi_link'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    attributes[:href] = options[:href]
    content = capture(&block) if block_given?
    tag(:a, content, attributes)
  end

  def mi_paragraph(options={}, &block)
    attributes={}
    attributes[:class] = 'mi_paragraph'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    tag(:p, (capture(&block) if block_given?), attributes)
  end

  def mi_row(options={}, &block)
    tag(:table, tag(:tr, (capture(&block) if block_given?)), :class => 'mi_row')
  end

  def mi_tab(options={})
    attributes={}
    attributes[:class] = 'mi_tab mi_click'
    if options[:controller] == controller_name || options[:selected] == true
      attributes[:type] = 'submit'
    else
      attributes[:id] = options[:url] if options[:url]
      attributes[:type] = 'button'
    end
    attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
    attributes[:value] = options[:label] if options[:label]
    self_closing_tag(:input, attributes)
  end

  def mi_title(text, options={})
    options[:size] ||= 1
    attributes={}
    attributes[:class] = 'mi_title'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    tag(%{h#{options[:size]}}, text, attributes)
  end

  def mi_tray(options={}, &block)
    attributes={}
    attributes[:class] = 'mi_tray'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    tag(:span, (capture(&block) if block_given?), attributes)
  end

end

include Merb::MerbInterface::ComponentsHelper