if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependency 'dm-validations'
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_password][:layout] ||= :application
  
  module MuiPassword
    def self.setup_router(scope)
      scope.match('/javascripts/mui_password.js').to(:controller => 'javascripts', :action => 'password').name(:mui_javascript_password)
      scope.to(:controller => 'passwords') do |p|
        p.match('/password/exit').to(:action => 'exit').name(:mui_password_exit)
        p.match('/password/create', :method => :post).to(:action => 'create_post').name(:mui_password_create)
        p.match('/password/create').to(:action => 'create').name(:mui_password_create)
        p.match('/password/read', :method => :post).to(:action => 'read_post').name(:mui_password_read)
        p.match('/password/read').to(:action => 'read').name(:mui_password_read)
        p.match('/password/update', :method => :post).to(:action => 'update_post').name(:mui_password_update)
        p.match('/password/update').to(:action => 'update').name(:mui_password_update)
        p.match('/password/delete', :method => :post).to(:action => 'delete_post').name(:mui_password_delete)
        p.match('/password/delete').to(:action => 'delete').name(:mui_password_delete)
      end
    end
  end

  MuiPassword.setup_default_structure!
  
end