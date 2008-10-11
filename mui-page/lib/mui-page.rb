if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_page][:layout] ||= :application
  
  module MuiPage
    def self.setup_router(scope)
      scope.to(:controller => 'pages') do |p|
        p.match('/pages').to(:action => 'index').name(:index)
        p.match('/page/create', :method => :post).to(:action => 'create_post').name(:create)
        p.match('/page/create').to(:action => 'create').name(:create)
        p.match('/page/read/:page_id').to(:action => 'read').name(:read)
        p.match('/page/update/:page_id', :method => :put).to(:action => 'update_put').name(:update)
        p.match('/page/update/:page_id').to(:action => 'update').name(:update)
        p.match('/page/delete/:page_id', :method => :put).to(:action => 'delete_put').name(:delete)
        p.match('/page/delete/:page_id').to(:action => 'delete').name(:delete)
      end
    end
  end

  MuiPage.setup_default_structure!
  
end