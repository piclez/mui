def mi_dialog_target
  attributes={}
  attributes[:class] = 'mi_dialog_target'
  element(:div, attributes)
end

def mi_dialog_window(options={}, &block)
  javascript = element(:script, :src => url(:mi_javascript_dialog), :type => 'text/javascript')
  attributes={}
  attributes[:class] = 'mi_dialog_row'
  html = element(:table, attributes) do
    element(:tr) do
      attributes[:class] = 'mi_dialog_column'
      element(:td, attributes) do
        attributes[:class] = 'mi_dialog_window'
        element(:span, attributes) do
          capture(&block) + mi_button(:dialog => 'close')
        end
      end
    end
  end
  javascript + html
end