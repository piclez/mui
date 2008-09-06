if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_page][:layout] ||= :application
  
  module MuiPage
    def self.setup_router(scope)
      scope.to(:controller => 'pages') do |p|
        p.match('/pages').to(:action => 'index').name(:mui_pages)
        p.match('/page/create', :method => :post).to(:action => 'create_post').name(:mui_page_create)
        p.match('/page/create').to(:action => 'create').name(:mui_page_create)
        p.match('/page/read/:id').to(:action => 'read').name(:mui_page_read)
        p.match('/page/update/:id', :method => :put).to(:action => 'update_put').name(:mui_page_update)
        p.match('/page/update/:id').to(:action => 'update').name(:mui_page_update)
        p.match('/page/delete/:id', :method => :put).to(:action => 'delete_put').name(:mui_page_delete)
        p.match('/page/delete/:id').to(:action => 'delete').name(:mui_page_delete)
      end
    end
  end

  MuiPage.setup_default_structure!
  
end