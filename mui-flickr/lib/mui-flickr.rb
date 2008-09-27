if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)
  Merb::Plugins.add_rakefiles('tasks/merb', 'tasks/slice')
  Merb::Slices::register(__FILE__)
  Merb::Slices::config[:mui_flickr][:layout] ||= :application
  
  module MuiFlickr
    def self.setup_router(scope)
      scope.match('/javascripts/mui_flickr.js').to(:controller => 'javascripts', :action => 'flickr').name(:mui_flickr_javascript)
      scope.to(:controller => 'photosets') do |a|
        a.match('/photo').to(:action => 'photo').name(:mui_flickr_photo)
        a.match('/photos').to(:action => 'index').name(:mui_flickr_photosets)
      end
    end
  end
  
  MuiFlickr.setup_default_structure!
  
end