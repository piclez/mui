def mi_dialog_target(options={})
  tag(:span, :class => 'mi_dialog_target')
end

def mi_dialog_tray(options={}, &block)
  tag(:span, capture(&block), :class => 'mi_dialog_tray')
end

def mi_dialog_window(options={}, &block)
  self_closing_tag(:script, :src => url(:mi_javascript_dialog), :type => 'text/javascript') + tag(:span, capture(&block), :class => 'mi_dialog_window')
end