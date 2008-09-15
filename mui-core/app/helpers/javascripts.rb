module Merb::MuiCore::MuiJavascripts
  
  def mui_javascript
    script = tag(:script, :src => '/javascripts/jquery-1.2.6.pack.js', :type => 'text/javascript')
    script << tag(:script, :src => '/javascripts/jquery.dimensions.pack.js', :type => 'text/javascript')
    script << tag(:script, :src => '/javascripts/jquery-ui-personalized-1.6b.packed.js', :type => 'text/javascript')
    script << tag(:script, :src => url(:mui_javascript), :type => 'text/javascript')
    script
  end

  def mui_javascript_window
    tag(:script, :src => url(:mui_javascript_window), :type => 'text/javascript')
  end

end

include Merb::MuiCore::MuiJavascripts