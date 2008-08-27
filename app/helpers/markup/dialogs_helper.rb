def mi_dialog(options={}, &block)
  attributes={}
  attributes[:class] = 'mi_dialog_row_background'
  html = element(:div, attributes)
  attributes[:class] = 'mi_dialog_row'
  html << element(:table, attributes) do
    element(:tr) do
      attributes[:class] = 'mi_dialog_column'
      element(:td, attributes) do
        attributes[:class] = 'mi_dialog_window'
        element(:span, attributes) do
          capture(&block)
        end
      end
    end
  end
  html
end

