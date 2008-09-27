module Merb::MuiCore::MuiMessages
  
  def mui_message(options = {}, &block)
    label = options[:title] || ''
    tone = options[:tone] || 'neutral'
    script = tag(:script, :src => url(:mui_javascript_message), :type => 'text/javascript')
    text = tag(:td, (label + capture(&block)))
    button = tag(:td, mui_button(:title => '&#215;', :message => 'close'), :align => 'right')
    script + tag(:div, tag(:table, tag(:tr, (text + button)), :class => 'mui_grid mui_grid_bar'), :class => %{mui_message mui_tone_#{tone}})
  end

end

include Merb::MuiCore::MuiMessages
