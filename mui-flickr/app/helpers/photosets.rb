module MuiFlickr::MuiPhotosets

  def mui_flickr(options = {}, &block)
    mui_stylesheet(:url => url(:mui_flickr_stylesheet)) + tag(:div, capture(&block), :class => 'mui_flickr')
  end
  
  def mui_flickr_button(options = {})
    attributes = {}
    attributes[:class] = 'mui_button mui_button_tone_neutral mui_click_window_open'
    farm = options[:farm]
    photo = options[:photo]
    attributes[:id] = url(:mui_flickr_photo, :id => photo.id, :photoset_id => @photoset.id)
    photo = mui_image("http://farm#{@photoset.farm}.static.flickr.com/#{photo.server}/#{photo.id}_#{photo.secret}_s.jpg", :height => 75, :width => 75)
    content = tag(:table, tag(:tr, tag(:td, photo)), :class => 'mui_grid mui_grid_button')
    tag(:button, content, attributes)
  end
  
  def mui_flickr_navigation
    navigation = ''
    navigation << mui_button(:title => '&larr;', :url => url(:mui_flickr_photo, :id => @previous_id, :photoset_id => @photoset.id), :window => 'redirect') if @previous_id
    navigation << mui_button(:title => '&rarr;', :url => url(:mui_flickr_photo, :id => @next_id, :photoset_id => @photoset.id), :window => 'redirect') if @next_id
    navigation
  end
  
  def mui_flickr_photo(options = {})
    farm = options[:farm]
    photo = options[:photo]
    mui_image("http://farm#{@photoset.farm}.static.flickr.com/#{@photo.server}/#{@photo.id}_#{@photo.secret}.jpg", :height => @height, :width => @width)
  end

  def mui_flickr_tab(options = {})
    photoset = options[:photoset]
    photo = mui_image("http://farm#{photoset.farm}.static.flickr.com/#{photoset.server}/#{photoset.primary}_#{photoset.secret}_s.jpg", :height => 75, :width => 75)
    attributes = {}
    attributes[:class] = 'mui_button mui_button_tone_neutral mui_click'
    attributes[:class] << ' mui_selected' if photoset.id == @photoset.id
    attributes[:id] = url(:mui_flickr_photosets, :id => photoset.id)
    attributes[:style] = 'width: 100%;'
    content = tag(:table, tag(:tr, tag(:td, photo) + tag(:td, photoset.title)), :class => 'mui_grid mui_grid_button')
    tag(:button, content, attributes)
  end
  
end

include MuiFlickr::MuiPhotosets