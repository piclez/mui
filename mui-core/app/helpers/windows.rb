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
    session.delete(:mui_window)
    script = tag(:script, :src => url(:mui_javascript_window), :type => 'text/javascript')
    bar = mui_bar(:title => options[:title], :type => 'window', :window => 'close')
    script + bar + tag(:span, capture(&block), :class => 'mui_window')
  end

end

include Merb::MuiCore::MuiWindows
