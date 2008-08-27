if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:merb_interface][:layout] ||= :application

  module MerbInterface
    def self.setup_router(scope)
      scope.match('/stylesheets/page.css').to(:controller => 'stylesheets', :action => 'page').name(:mi_stylesheet_page)
      scope.match('/javascripts/page.js').to(:controller => 'javascripts', :action => 'page').name(:mi_javascript_page)
      scope.match('/javascripts/dialog.js').to(:controller => 'javascripts', :action => 'dialog').name(:mi_javascript_dialog)
    end
  end
  
  MerbInterface.setup_default_structure!
  
end