module Merb::MerbInterface::ResourcesHelper
  
  def mi_resource(options={})
    if options[:type] == 'stylesheet'
      element(:link, :charset => 'utf-8', :href => url(:mi_stylesheets), :media => 'all', :rel => 'Stylesheet', :type => 'text/css')
    elsif options[:type] == 'javascript'
      element(:script, :src => url(:mi_javascripts), :type => 'text/javascript')
    end
  end

end

include Merb::MerbInterface::ResourcesHelper