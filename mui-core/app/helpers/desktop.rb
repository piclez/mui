module Merb::MuiCore::MuiDesktop
  
  def mui(options = {}, &block)
    output = ''
    if message = session[:mui_message]
      content = mui_button(:title => '&#215;', :message => 'close')
      content << message[:title] if message[:title]
      content << message[:body] if message[:body]
      output << tag(:div, content, :class => %{mui_message mui_message_#{message[:tone]}})
      session.delete(:mui_message)
    end
    output << capture(&block) if block_given?
    output << tag(:div, :class => 'mui_window_target')
    if session[:mui_window]
      output << tag(:script, "windowOpen('#{session[:mui_window]}');", :type => 'text/javascript')    	
      session.delete(:mui_window)
    end
    output
  end

  def mui_block(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_block'
    if type = options[:type]
      if type == 'inline'
        tag_type = :span
      else
        tag_type = :div
        attributes[:class] << %{ mui_block_#{type}}
      end
    else
      tag_type = :div
    end
    if options[:height] || options[:width]
      attributes[:style] = ''
      attributes[:style] << %{height:#{options[:height]};} if options[:height]
      attributes[:style] << %{width:#{options[:width]};} if options[:width]
    end
    content = ''
    if options[:title]
      title_size = options[:title_size] || '2em'
      title_attributes = {}
      title_attributes[:class] = 'mui_block_title'
      title_attributes[:style] = %{font-size:#{title_size}}
      content << tag(:h1, options[:title], title_attributes)
    end
    content << capture(&block) if block_given?
    tag(tag_type, content, attributes)
  end
  
  def mui_button(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_button'
    attributes[:class] << %{ mui_button_tone_#{options[:tone] || 'neutral'}}
    attributes[:class] << ' mui_click'
    attributes[:class] << %{_message_#{options[:message]}} if options[:message]
    attributes[:class] << %{_window_#{options[:window]}} if options[:window]
    attributes[:id] = options[:url] if options[:url]
    attributes[:name] = options[:name] if options[:name]
    attributes[:style] = %{width:#{options[:width]};} if options[:width]
    attributes[:type] = options[:submit] == true ? 'submit' : 'button'
    attributes[:value] = options[:title] if options[:title]
    if block_given?
      if options[:title]
        content = tag(:table, tag(:tr, tag(:td, capture(&block)) + tag(:td, options[:title], :width => '100%')))
      else
        content = capture(&block)
      end
      tag(:button, content, attributes)
    else
      self_closing_tag(:input, attributes)
    end
  end

  def mui_desktop(options = {}, &block)
    tag(:div, capture(&block), :class => 'mui_desktop')
  end

  def mui_image(options={})
    attributes={}
    attributes[:align] = options[:align] if options[:align]
    attributes[:class] = 'mui_image'
    attributes[:class] << ' mui_image_border' if options[:border] == true
    if options[:height] && options[:width]
      attributes[:class] << ' mui_image_rounded' if options[:rounded] == true
      attributes[:src] = '/images/nil.png'
      attributes[:style] = %{background-image: url('#{options[:url]}');}
      attributes[:style] << %{height: #{options[:height]}px;}
      attributes[:style] << %{width: #{options[:width]}px;}
    else
      attributes[:src] = file
    end
    attributes[:class] << ' mui_photo' if options[:photo] == true
    attributes[:class] << ' mui_inline' if options[:inline] == true
    self_closing_tag(:img, attributes)
  end
  
  def mui_link(options={}, &block)
    attributes = {}
    attributes[:class] = 'mui_link'
    attributes[:href] = options[:url]
    if block_given?
      content = capture(&block)
      attributes[:title] = options[:title]
    else
      content = options[:title]
    end
    tag(:a, content, attributes)
  end

  def mui_list(parents = [])
    children = ''
    parents.each do |p|
      p.each do |c|
        children << tag(:li, c, :class => 'mui_list_item')
      end
    end
    tag(:ul, children, :class => 'mui_list')
  end

  def mui_paragraph(options={}, &block)
    tag(:p, (capture(&block) if block_given?), :class => 'mui_paragraph')
  end

end

include Merb::MuiCore::MuiDesktop
