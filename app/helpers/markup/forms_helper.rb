module Merb::MerbInterface::FormsHelper

  def mi_form(options = {})
    if options[:model]
      form_for(options[:model], :action => options[:action], :class => 'mi_form') do
        yield if block_given?
      end
    else
      form(:action => options[:action], :class => 'mi_form') do
        yield if block_given?
      end
    end
  end

  def mi_form_check(name, options = {})
    attributes = {}
    attributes[:class] = 'mi_form_check'
    attributes[:label] = options[:label]
    form_block(options) do
      checkbox(name, attributes)
    end
  end
  
  def mi_form_password(name, options = {})
    attributes = {}
    attributes[:class] = 'mi_form_field'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      password_field(name, attributes)
    end
  end
  
  def mi_form_menu(name, options = {})
    
  end
  
  def mi_form_search(name, options = {})
    
  end
  
  def mi_form_text(name, options = {})
    attributes = {}
    attributes[:class] = 'mi_form_field'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      text_field(name, attributes)
    end
  end
  
  def mi_form_text_area(name, options = {})
    attributes = {}
    attributes[:class] = 'mi_form_text_area'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:label] = options[:label]
    form_block(options) do
      text_area(name, attributes)
    end
  end
  
  private
  
  def form_block(options = {})
    attributes = {}
    attributes[:class] = 'mi_form_block'
    attributes[:class] << '_optional' if options[:optional] == true
    attributes[:class] << ' mi_inline' if options[:inline] == true
    tag(:span, yield, attributes)
  end
  
end

include Merb::MerbInterface::FormsHelper