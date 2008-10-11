if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependencies('merb-slices', 'merb-helpers')
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_core][:layout] ||= :application

  module MuiCore
    def self.setup_router(scope)
      scope.match('/stylesheets/mui.css').to(:controller => 'stylesheets', :action => 'index').name(:stylesheet)
      scope.with(:controller => 'javascripts') do |j|
        j.match('/javascripts/mui_desktop.js').to(:action => 'desktop').name(:javascript_desktop)
        j.match('/javascripts/mui_message.js').to(:action => 'message').name(:javascript_message)
        j.match('/javascripts/mui_window.js').to(:action => 'window').name(:javascript_window)
      end
    end
  end

  MuiCore.setup_default_structure!

end