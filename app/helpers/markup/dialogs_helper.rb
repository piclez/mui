def mi_dialog_target(options={}, &block)
  attributes={}
  attributes[:class] = 'mi_dialog_target'
  element(:span, attributes)
end

def mi_dialog_tray(options={}, &block)
  attributes={}
  attributes[:class] = 'mi_dialog_tray'
  element(:span, attributes) do
    capture(&block)
  end
end

def mi_dialog_window(options={}, &block)
  javascript = element(:script, :src => url(:mi_javascript_dialog), :type => 'text/javascript')
  attributes={}
  attributes[:class] = 'mi_dialog_window'
  html = element(:span, attributes) do
    capture(&block)
  end
  javascript + html
end