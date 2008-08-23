if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:merb_interface][:layout] ||= :application

  module MerbInterface
    def self.setup_router(scope)
      scope.match('/stylesheets/interface.css').to(:controller => 'stylesheets', :action => 'interface').name(:merb_interface_stylesheets)
      scope.match('/javascripts/interface.js').to(:controller => 'javascripts', :action => 'interface').name(:merb_interface_javascripts)
    end
  end
  
  MerbInterface.setup_default_structure!

  Merb::BootLoader.after_app_loads do
    Merb.add_mime_type(:css, :to_css, %w[text/css])
  end
  
end