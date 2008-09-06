module Merb::MuiCore::JavascriptsHelper
  
  def mui_javascript
    script = self_closing_tag(:script, :src => '/javascripts/jquery-1.2.6.pack.js', :type => 'text/javascript')
    script << self_closing_tag(:script, :src => '/javascripts/jquery.dimensions.pack.js', :type => 'text/javascript')
    script << self_closing_tag(:script, :src => '/javascripts/jquery-ui-personalized-1.6b.packed.js', :type => 'text/javascript')
    script << self_closing_tag(:script, :src => url(:mui_javascript), :type => 'text/javascript')
    script
  end

  def mui_javascript_dialog
    self_closing_tag(:script, :src => url(:mui_javascript_dialog), :type => 'text/javascript')
  end

end

include Merb::MuiCore::JavascriptsHelper