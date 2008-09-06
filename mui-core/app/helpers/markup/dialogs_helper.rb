module Merb::MuiCore::DialogsHelper

  def mui_dialog_target(options={})
    tag(:span, :class => 'mui_dialog_target')
  end

  def mui_dialog_tray(options={}, &block)
    tag(:span, capture(&block), :class => 'mui_dialog_tray')
  end

  def mui_dialog_window(options={}, &block)
    self_closing_tag(:script, :src => url(:mui_javascript_dialog), :type => 'text/javascript') + tag(:span, capture(&block), :class => 'mui_dialog_window')
  end

end

include Merb::MuiCore::DialogsHelper