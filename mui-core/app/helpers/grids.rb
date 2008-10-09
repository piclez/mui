module Merb::MuiCore::MuiGrids
  
  def mui_grid(options = {}, &block)
    return unless block_given?
    @@mui_cell_count = 0
    @@mui_cell_limit = options[:columns] || 1
    @@mui_cell_width = options[:cell_width]
    attributes = {}
    attributes[:class] = 'mui_grid'
    attributes[:style] = %{width:#{options[:width]}} if options[:width]
    tag(:table, tag(:tr, capture(&block)), attributes)
  end
  
  def mui_cell(options = {}, &block)
    return unless block_given?
    @@mui_cell_count += 1
    attributes = {}
    attributes[:align] = options[:align] if options[:align]
    if options[:width]
      attributes[:style] = %{width:#{options[:width]}}
    else
      attributes[:style] = %{width:#{@@mui_cell_width}} if @@mui_cell_width
    end
    attributes[:valign] = options[:valign] || 'top'
    html = ''
    if @@mui_cell_count > @@mui_cell_limit
      @@mui_cell_count = 0
      html << close_tag(:tr) + open_tag(:tr)
    end
    html << tag(:td, capture(&block), attributes)
  end
  
end

include Merb::MuiCore::MuiGrids
