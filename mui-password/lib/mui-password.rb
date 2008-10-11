if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  load_dependency 'dm-validations'
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_password][:layout] ||= :application
  
  module MuiPassword
    def self.setup_router(scope)
      scope.match('/javascripts/mui_password.js').to(:controller => 'javascripts', :action => 'password').name(:javascript)
      scope.to(:controller => 'passwords') do |p|
        p.match('/password/exit').to(:action => 'exit').name(:exit)
        p.match('/password/create', :method => :post).to(:action => 'create_post').name(:create)
        p.match('/password/create').to(:action => 'create').name(:create)
        p.match('/password/read', :method => :post).to(:action => 'read_post').name(:read)
        p.match('/password/read').to(:action => 'read').name(:read)
        p.match('/password/update', :method => :post).to(:action => 'update_post').name(:update)
        p.match('/password/update').to(:action => 'update').name(:update)
        p.match('/password/delete', :method => :post).to(:action => 'delete_post').name(:delete)
        p.match('/password/delete').to(:action => 'delete').name(:delete)
      end
    end
  end

  MuiPassword.setup_default_structure!
  
end