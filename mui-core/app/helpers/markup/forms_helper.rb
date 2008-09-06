module Merb::MuiCore::FormsHelper

  def mui_form(options = {})
    if options[:model]
      form_for(options[:model], :action => options[:action], :class => 'mui_form') do
        yield if block_given?
      end
    else
      form(:action => options[:action], :class => 'mui_form') do
        yield if block_given?
      end
    end
  end

  def mui_form_check(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_form_check'
    attributes[:label] = options[:label]
    form_block(options) do
      checkbox(name, attributes)
    end
  end
  
  def mui_form_password(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_form_field'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      password_field(name, attributes)
    end
  end
  
  def mui_form_menu(name, options = {})
    
  end
  
  def mui_form_search(name, options = {})
    
  end
  
  def mui_form_text(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_form_field'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      text_field(name, attributes)
    end
  end
  
  def mui_form_text_area(name, options = {})
    attributes = {}
    attributes[:class] = 'mui_form_text_area'
    attributes[:class] << ' mui_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      text_area(name, attributes)
    end
  end
  
  private
  
  def form_block(options = {})
    attributes = {}
    attributes[:class] = 'mui_form_block'
    attributes[:class] << '_optional' if options[:optional] == true
    attributes[:class] << ' mui_inline' if options[:inline] == true
    tag(:span, yield, attributes)
  end
  
end

include Merb::MuiCore::FormsHelper