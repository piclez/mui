if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:merb_interface][:layout] ||= :application

  module MerbInterface
    def self.setup_router(scope)
      scope.match('/stylesheets/interface.css').to(:controller => 'stylesheets', :action => 'interface').name(:mi_stylesheets)
      scope.match('/javascripts/interface.js').to(:controller => 'javascripts', :action => 'interface').name(:mi_javascripts)
    end
  end
  
  MerbInterface.setup_default_structure!
  
end