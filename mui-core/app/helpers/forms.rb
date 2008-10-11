module Merb::MuiCore::MuiForms

  def mui_form(options = {})
    if options[:model]
      form_for(options[:model], :action => options[:action]) do
        yield if block_given?
      end
    else
      form(:action => options[:action]) do
        yield if block_given?
      end
    end
  end

  def mui_check(name, options = {})
    columns = tag(:td, check_box(name, :class => 'mui_check'))
    columns << tag(:td, tag(:label, options[:title]))
    tag(:table, tag(:tr, columns))
  end
  
  def mui_password(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_password'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:title]
    password_field(name, attributes)
  end
  
  def mui_menu(name, options = {})
    
  end
  
  def mui_search(name, options = {})
    
  end
  
  def mui_text(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_text'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:title]
    attributes[:style] = %{width:#{options[:width]};} if options[:width]
    text_field(name, attributes)
  end
  
  def mui_hyper_text(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_hyper_text'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:title]
    text_area(name, attributes)
  end
  
end

include Merb::MuiCore::MuiForms
