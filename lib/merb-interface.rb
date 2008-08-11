if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependencies('merb-slices')
  Merb::Plugins.add_rakefiles 'merb-interface/merbtasks', 'merb-interface/slicetasks'
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:merb_interface][:layout] ||= :merb_interface

  module MerbInterface
    self.description = "Merb Interface"
    self.version = "0.9.4"
    self.author = "Jamie Hoover"
    def self.setup_router(scope)
      # Dynamic CSS via ERB views
      scope.match('/style.css').to(:controller => 'style', :action => 'index').name(:merb_interface_style)
      # Dynamic JS via ERB views
      scope.match('/script.js').to(:controller => 'script', :action => 'index').name(:merb_interface_script)
    end
  end

  MerbInterface.setup_default_structure!

  Merb::BootLoader.after_app_loads do
    # Markup helper for the host application
    Merb::Controller.send(:include, Merb::MerbInterface::MarkupHelper)
    # Dynamic CSS format for Style controller
    Merb.add_mime_type(:css, :to_css, %w[text/css])
  end
  
end