module Merb::MerbInterface::ElementsHelper

  def element(name, attributes = {})
    if block_given?
      start_tag(name, attributes) + yield.to_s + end_tag(name)
    elsif name == :a || name ==:div || name == :script || name == :span
      start_tag(name, attributes) + end_tag(name)
    else
      self_closing_tag(name, attributes)
    end
  end

  private

  def start_tag(name, attributes = nil)
    %{<#{name} #{filter(attributes) if attributes && !attributes.empty?}>}
  end

  def end_tag(name)
    %{</#{name}>}
  end

  def self_closing_tag(name, attributes = nil)
    %{<#{name} #{filter(attributes) if attributes && !attributes.empty?}/>}
  end

  def filter(attributes = {})
    boolean_attributes = Set.new(%w(disabled readonly multiple checked selected))
    attributes = attributes.to_mash
    attributes.each do |name, value|
      if boolean_attributes.include?(name)
        if value
          attributes[name] = name
        else
          attributes.delete(name)
        end
      else
        attributes[name] = escape_xml(value)
      end
    end
    attributes.to_xml_attributes
  end

end

include Merb::MerbInterface::ElementsHelper