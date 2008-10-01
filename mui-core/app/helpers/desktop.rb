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

  def mui_bar(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_bar'
    attributes[:class] << %{ mui_bar_#{options[:type]}} if options[:type]
    columns = ''
    columns << tag(:td, capture(&block), :class => 'mui_bar_tabs') if block_given?
    columns << tag(:td, options[:title], :class => 'mui_bar_title') if options[:title]
    buttons = ''
    buttons << options[:buttons] if options[:buttons]
    if options[:password] and mui_password?
      buttons << mui_button(:title => 'Password', :url => url(:mui_password_update), :window => 'open')
      buttons << mui_button(:title => 'Exit', :url => url(:mui_password_exit))
    end
    buttons << mui_button(:title => '&#215;', :window => 'close') if options[:window] == 'close'
    columns << tag(:td, buttons, :class => 'mui_bar_buttons')
    tag(:div, tag(:table, tag(:tr, columns)), attributes)
  end

  def mui_block(&block)
    tag(:span, (capture(&block) if block_given?), :class => 'mui_block')
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
        content = tag(:table, tag(:tr, tag(:td, capture(&block)) + tag(:td, options[:title], :class => 'mui_button_text')))
      else
        content = capture(&block)
      end
      tag(:button, content, attributes)
    else
      self_closing_tag(:input, attributes)
    end
  end

  def mui_column(options = {}, &block)
    attributes = {}
    if options[:x]
      attributes[:align] = 'left' if options[:x] <= 0
      attributes[:align] = 'center' if options[:x] == 0.5
      attributes[:align] = 'right' if options[:x] >= 1
    end
    attributes[:class] = 'mui_column'
    attributes[:class] << %{ mui_column_#{options[:type]}} if options[:type]
    attributes[:colspan] = options[:span] if options[:span]
    if options[:y]
      attributes[:valign] = 'top' if options[:y] <= 0
      attributes[:valign] = 'middle' if options[:y] == 0.5
      attributes[:valign] = 'bottom' if options[:y] >= 1
    end
    attributes[:width] = options[:width] if options[:width]
    title_attributes = {}
    title_attributes[:class] = 'mui_title'
    title_attributes[:class] << %{ mui_title_#{options[:type]}} if options[:type]
    content = ''
    content << tag(:h1, options[:title], title_attributes) if options[:title]
    content << capture(&block) if block_given?
    tag(:td, content, attributes)
  end

  def mui_desktop(options = {}, &block)
    tag(:div, capture(&block), :class => 'mui_desktop')
  end

  def mui_grid(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_grid'
    attributes[:class] << %{ mui_grid_#{options[:type]}} if options[:type]
    tag(:table, capture(&block), attributes)
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

  def mui_inline(&block)
    tag(:span, (capture(&block) if block_given?), :class => 'mui_inline')
  end
  
  def mui_link(options={}, &block)
    attributes = {}
    attributes[:class] = 'mui_link'
    attributes[:class] << ' mui_link_external' if options[:external]
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
    attributes={}
    attributes[:class] = 'mui_paragraph'
    attributes[:class] << ' mui_inline' if options[:inline] == true
    tag(:p, (capture(&block) if block_given?), attributes)
  end

  def mui_row(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_row'
    attributes[:class] << %{_#{options[:type]}} if options[:type]
    attributes[:valign] = 'top' unless options[:type] == 'bar'
    tag(:tr, capture(&block), attributes)
  end

  def mui_tab(options={})
    attributes={}
    attributes[:class] = 'mui_tab'
    attributes[:class] << ' mui_tab_selected' if options[:controller] == controller_name || options[:selected] == true
    attributes[:href] = options[:url] if options[:url]
    tag(:a, options[:title], attributes)
  end

end

include Merb::MuiCore::MuiDesktop
