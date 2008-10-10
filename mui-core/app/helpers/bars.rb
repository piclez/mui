module Merb::MuiCore::MuiBars
  
  def mui_bar(options = {}, &block)
    @@mui_bar_tab_width = options[:tab_width] if options[:tab_width]
    attributes = {}
    attributes[:class] = 'mui_bar'
    attributes[:class] << %{_#{options[:type]}} if options[:type]
    content = ''
    content << tag(:td, tag(:h1, options[:title], :class => 'mui_bar_title')) if options[:title]
    content << capture(&block) if block_given?
    tag(:table, tag(:tr, content), attributes)
  end
  
  def mui_tab(options = {}, &block)
    attributes = {}
    attributes[:class] = 'mui_tab'
    attributes[:class] << ' mui_selected' if options[:controller] == controller_name || options[:selected] == true
    attributes[:href] = options[:url] if options[:url]
    if options[:width]
      attributes[:style] = %{width:#{options[:width]}}
    elsif @@mui_bar_tab_width
      attributes[:style] = %{width:#{@@mui_bar_tab_width}}
    end
    attributes[:valign] = options[:valign] || 'top'
    tag(:td, tag(:a, options[:title], attributes), :style => attributes[:style])
  end
  
  def mui_bar_end(&block)
    tag(:td, capture(&block), :class => 'mui_bar_end')
  end
  
end

include Merb::MuiCore::MuiBars
