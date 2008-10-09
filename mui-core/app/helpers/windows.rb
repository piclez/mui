module Merb::MuiCore::MuiWindows
  
  def mui_window_redirect
    url = session[:mui_referer] || '/'
    session.delete(:mui_referer)
    redirect(url)
  end
  
  def mui_window_referer
    session[:mui_referer] = request.referer
  end

  def mui_window(options = {}, &block)
    script = tag(:script, :src => url(:mui_javascript_window), :type => 'text/javascript')
    bar_content = ''
    bar_content << tag(:td, options[:buttons], :class => 'mui_bar_buttons') if options[:buttons]
    bar_content << tag(:td, options[:title], :class => 'mui_window_title') if options[:title]
    bar_content << tag(:td, mui_button(:title => '&#215;', :window => 'close'), :class => 'mui_bar_end')
    bar = tag(:tr, tag(:td, tag(:table, tag(:tr, bar_content), :class => 'mui_window_bar')))
    content = tag(:tr, tag(:td, capture(&block), :class => 'mui_window_content'))
    script + tag(:table, bar + content, :class => 'mui_window')
  end
  
end

include Merb::MuiCore::MuiWindows
