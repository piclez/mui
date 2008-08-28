module Merb::MerbInterface::ResourcesHelper
  
  def mi_resource(options={})
    if options[:type] == 'stylesheet'
      element(:link, :charset => 'utf-8', :href => url(:mi_stylesheet_page), :media => 'all', :rel => 'Stylesheet', :type => 'text/css')
    elsif options[:type] == 'javascript'
      html = element(:script, :src => '/javascripts/jquery-1.2.6.pack.js', :type => 'text/javascript')
      html << element(:script, :src => '/javascripts/jquery.dimensions.pack.js', :type => 'text/javascript')
      html << element(:script, :src => '/javascripts/jquery-ui-personalized-1.6b.packed.js', :type => 'text/javascript')
      html << element(:script, :src => url(:mi_javascript_page), :type => 'text/javascript')
      html
    end
  end

end

include Merb::MerbInterface::ResourcesHelper