module Merb::MerbInterface::FormsHelper

  def mi_form(options = {}, &block)
    @model = options[:model] if options[:model]
    attributes = {}
    attributes[:action] = options[:action] if options[:action]
    attributes[:class] = 'mi_form'
    attributes[:method] = 'post'
    element(:form, attributes) do
      capture(&block) if block_given?
    end
  end

  def mi_form_check(options = {})
    options[:label] ||= options[:field]
    attributes = {}
    attributes[:class] = 'mi_form_text'
    attributes[:checked] = 'checked' if options[:selected] == true
    attributes[:name] = options[:field] || nil
    field(:inline => options[:inline]) do
      element(:input, attributes) + label(options)
    end
  end
  
  def mi_form_password(options = {})
    options[:label] ||= options[:field]
    attributes = {}
    attributes[:class] = 'mi_form_text'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:name] = options[:field] if options[:field]
    field(options) do
      attributes[:type] = 'password'
      field = options[:field]
      label(:label => options[:label]) + element(:input, attributes)
    end
  end
  
  def mi_form_menu(options = {})
    
  end
  
  def mi_form_search(options = {})
    
  end
  
  def mi_form_text(options = {})
    options[:label] ||= options[:field]
    attributes = {}
    attributes[:class] = 'mi_form_text'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:name] = options[:field] if options[:field]
    field(options) do
      attributes[:type] = 'text'
      field = options[:field]
      attributes[:value] = options[:field]
      label(:label => options[:label]) + element(:input, attributes)
    end
  end
  
  def mi_form_text_area(options = {})
    options[:label] ||= options[:field]
    attributes = {}
    attributes[:class] = 'mi_form_text'
    attributes[:class] << ' mi_focus' if options[:focus] == true
    attributes[:name] = options[:field] if options[:field]
    field(options) do
      attributes[:class] << 'area'
      label(options) + element(:textarea, attributes){options[:text] if options[:text]}
    end
  end
  
  private
  
  def bound?(*args)
    args.first.is_a?(Symbol)
  end
  
  def field(options = {}, &block)
    options[:inline] ||= false
    attributes = {}
    attributes[:class] = 'mi_field'
    attributes[:class] << ' mi_inline' if options[:inline] == true
    attributes[:style] = 'margin-right: 1.25em;' if options[:resize] == true
    element(:span, attributes) do
      yield if block_given?
    end
  end
  
  def label(options = {})
    options[:inline] ||= false
    attributes = {}
    attributes[:class] = 'mi_field_label'
    attributes[:class] << '_optional' if options[:optional] == true
    attributes[:class] << ' mi_inline' if options[:inline] == true
    attributes[:for] = options[:id] if options[:id]
    element(:label, attributes) do
      options[:label]
    end
  end
  
end

include Merb::MerbInterface::FormsHelper