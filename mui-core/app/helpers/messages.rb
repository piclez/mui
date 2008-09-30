module Merb::MuiCore::MuiMessages
  
  def mui_message(options = {}, &block)
    tone = options[:tone] || 'neutral'
    content = tag(:script, :src => url(:mui_javascript_message), :type => 'text/javascript')
    content << mui_button(:title => '&#215;', :message => 'close')
    content << options[:title] || ''
    content << capture(&block) if block_given?
    tag(:div, content, :class => %{mui_message mui_message_#{tone}})
  end

end

include Merb::MuiCore::MuiMessages
