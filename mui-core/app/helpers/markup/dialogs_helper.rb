module Merb::MuiCore::DialogsHelper
  
  def mui_dialog_target(options = {})
    tag(:span, :class => 'mui_dialog_target')
  end

  def mui_dialog_window(options = {}, &block)
    script = self_closing_tag(:script, :src => url(:mui_javascript_dialog), :type => 'text/javascript')
    td = tag(:span, options[:label], :class => 'mui_bar_label') if options[:label]
    tr = tag(:td, td)
    tr << tag(:td, mui_button(:dialog => 'close', :label => '&#215;', :tone => 'negative'), :align => 'right')
    table = tag(:table, tag(:tr, tr), :class => 'mui_dialog_bar', :width => '100%')
    span = tag(:span, capture(&block), :class => 'mui_dialog_tray')
    html = script + table + span
    tag(:span, html, :class => 'mui_dialog_window')
  end

end

include Merb::MuiCore::DialogsHelper