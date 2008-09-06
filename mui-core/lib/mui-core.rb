if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependencies('merb-slices', 'merb_helpers')
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_core][:layout] ||= :application

  module MuiCore
    def self.setup_router(scope)
      scope.match('/stylesheets/mui.css').to(:controller => 'stylesheets', :action => 'index').name(:mui_stylesheet)
      scope.to(:controller => 'javascripts') do |j|
        j.match('/javascripts/mui.js').to(:action => 'index').name(:mui_javascript)
        j.match('/javascripts/mui_dialog.js').to(:action => 'dialog').name(:mui_javascript_dialog)
      end
    end
  end

  MuiCore.setup_default_structure!

end