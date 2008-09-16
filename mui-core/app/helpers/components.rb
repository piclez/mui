module Merb::MuiCore::MuiComponents
  
  def mui_bar(options = {}, &block)
    content = ''
    content << tag(:span, options[:label], :class => 'mui_bar_label') if options[:label]
    content << capture(&block) if block_given?
    tag(:div, content, :class => %{mui_bar#{'_expanded' if options[:expanded] == true}})
  end

  def mui_button(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_button'
    attributes[:class] << %{ mui_tone_#{options[:tone] || 'neutral'}}
    attributes[:class] << ' mui_inline' if options[:inline] == true
    attributes[:class] << ' mui_click'
    attributes[:class] << %{_message_#{options[:message]}} if options[:message]
    attributes[:class] << %{_window_#{options[:window]}} if options[:window]
    attributes[:id] = options[:url] if options[:url]
    attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
    attributes[:type] = options[:submit] == true ? 'submit' : 'button'
    attributes[:value] = options[:label] if options[:label]
    if block_given?
      if options[:label]
        content = tag(:table, tag(:tr, tag(:td, capture(&block)) + tag(:td, options[:label], :class => 'mui_button_text')))
      else
        content = capture(&block)
      end
      tag(:button, content, attributes)
    else
      self_closing_tag(:input, attributes)
    end
  end

  def mui_column(attributes={}, &block)
    attributes[:valign] ||= 'top'
    tag(:td, (capture(&block) if block_given?), attributes)
  end

  def mui_image(file, options={})
    attributes={}
    attributes[:align] = options[:align] if options[:align]
    attributes[:class] = 'mui_image'
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
    attributes[:class] << ' mui_photo' if options[:photo] == true
    attributes[:class] << ' mui_inline' if options[:inline] == true
    self_closing_tag(:img, attributes)
  end

  def mui_link(content, options={}, &block)
    attributes = {}
    attributes[:class] = 'mui_link'
    attributes[:class] << ' mui_inline' if options[:inline] == true
    attributes[:href] = options[:href]
    content = capture(&block) if block_given?
    tag(:a, content, attributes)
  end

  def mui_paragraph(options={}, &block)
    attributes={}
    attributes[:class] = 'mui_paragraph'
    attributes[:class] << ' mui_inline' if options[:inline] == true
    tag(:p, (capture(&block) if block_given?), attributes)
  end

  def mui_row(attributes={}, &block)
    attributes[:class] = 'mui_row'
    attributes[:width] ||= '100%'
    tag(:table, tag(:tr, (capture(&block) if block_given?)), attributes)
  end

  def mui_tab(options={})
    attributes={}
    attributes[:class] = 'mui_tab'
    attributes[:class] << '_selected' if options[:controller] == controller_name || options[:selected] == true
    attributes[:class] << ' mui_inline' if options[:inline] == true
    attributes[:class] << ' mui_click'
    attributes[:class] << %{_message_#{options[:message]}} if options[:message]
    attributes[:class] << %{_window_#{options[:window]}} if options[:window]
    attributes[:id] = options[:url] if options[:url]
    attributes[:style] = %{width:#{options[:width]}em;} if options[:width]
    attributes[:type] = 'button'
    attributes[:value] = options[:label] if options[:label]
    self_closing_tag(:input, attributes)
  end

  def mui_title(text, options={})
    options[:size] ||= 1
    attributes={}
    attributes[:class] = 'mui_title'
    attributes[:class] << ' mui_inline' if options[:inline] == true
    tag(%{h#{options[:size]}}, text, attributes)
  end

  def mui_tray(options={}, &block)
    attributes={}
    attributes[:class] = 'mui_tray'
    attributes[:class] << ' mui_inline' if options[:inline] == true
    tag(:span, (capture(&block) if block_given?), attributes)
  end

end

include Merb::MuiCore::MuiComponents