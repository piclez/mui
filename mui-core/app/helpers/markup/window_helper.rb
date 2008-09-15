module Merb::MuiCore::WindowHelper
  
  def mui_window_redirect(options = {})
    referer = session[:mui_window_referer] || '/'
    session.delete(:mui_window_referer)
    redirect(referer)
  end
  
  def mui_window_referer_create
    session[:mui_window_referer] = request.referer
  end

  def mui_window_target(options = {})
    html = tag(:span, :class => 'mui_window_target')
    if session[:mui_window]
      script = "$(document).ready(function(){"
      script << "$('.mui_window_target').hide().load('#{session[:mui_window]}').fadeIn();"
      script << "});"
      html << tag(:script, script, :type => 'text/javascript')
    end
    html
  end

  def mui_window(options = {}, &block)
    session.delete(:mui_window)
    script = tag(:script, :src => url(:mui_javascript_window), :type => 'text/javascript')
    td = tag(:span, options[:label], :class => 'mui_bar_label') if options[:label]
    tr = tag(:td, td)
    tr << tag(:td, mui_button(:window => 'close', :label => '&#215;', :tone => 'negative'), :align => 'right')
    table = tag(:table, tag(:tr, tr), :class => 'mui_window_bar', :width => '100%')
    span = tag(:span, capture(&block), :class => 'mui_window_tray')
    html = script + table + span
    tag(:span, html, :class => 'mui_window')
  end

end

include Merb::MuiCore::WindowHelper