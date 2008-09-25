class MuiFlickr::Photosets < MuiFlickr::Application

  load_dependency 'flickraw'
  
  FlickRaw.api_key = MuiFlickr[:api_key]
  FlickRaw.shared_secret = MuiFlickr[:shared_secret]

  def index
    @photosets = flickr.photosets.getList :user_id => user_id
    photoset_id = params[:id] || @photosets.first.id
    @photoset = flickr.photosets.getInfo(:photoset_id => photoset_id)
    @photos = flickr.photosets.getPhotos(:photoset_id => photoset_id).photo
    display @photosets
  end

  def photo
    @photoset = flickr.photosets.getInfo(:photoset_id => params[:photoset_id])
    @photo = flickr.photos.getInfo(:photo_id => params[:id], :secret => params[:secret])
    sizes = flickr.photos.getSizes :photo_id => @photo.id
    original = sizes.find {|s| s.label == 'Medium'}
    @height = original.height
    @width = original.width
    context = flickr.photosets.getContext(:photo_id => params[:id], :photoset_id => @photoset.id)
    @next_id = context.nextphoto.id unless context.nextphoto.id == 0
    @previous_id = context.prevphoto.id unless context.prevphoto.id == 0
    display(@photo, :layout => false)
  end

  private

  def user_id
    flickr.people.findByUsername(:username => MuiFlickr[:user_name]).nsid
  end
      
end