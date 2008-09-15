module Merb::MuiCore::MuiMessages
  
  def mui_message_target
    html = tag(:span, :class => 'mui_message_target')
    if session[:mui_message]
      script = "$(document).ready(function(){"
      script << "$('.mui_message_target').hide().load('#{url(:mui_message)}').fadeIn();"
      script << "});"
      html << tag(:script, script, :type => 'text/javascript')
    end
    html
  end

  def mui_message(options = {}, &block)
    tone = options[:tone] || 'neutral'
    script = tag(:script, :src => url(:mui_javascript_message), :type => 'text/javascript')
    tr = tag(:td, capture(&block), :class => 'mui_message_tray')
    tr << tag(:td, mui_button(:label => '&#215;', :message => 'close'), :align => 'right')
    table = tag(:table, tag(:tr, tr), :class => 'mui_message_bar', :width => '100%')
    html = script + table
    tag(:span, html, :class => %{mui_message mui_message_tone_#{tone}})
  end

end

include Merb::MuiCore::MuiMessages