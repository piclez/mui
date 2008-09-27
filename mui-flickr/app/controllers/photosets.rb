class MuiFlickr::Photosets < MuiFlickr::Application

  load_dependency 'flickraw'
  
  FlickRaw.api_key = MuiFlickr[:api_key]
  FlickRaw.shared_secret = MuiFlickr[:shared_secret]

  def index
    @photosets = flickr.photosets.getList :user_id => user_id
    photoset_id = params[:photoset_id] || @photosets.first.id
    @photoset = flickr.photosets.getInfo(:photoset_id => photoset_id)
    @photos = flickr.photosets.getPhotos(:photoset_id => photoset_id).photo
    display @photosets
  end

  def photo
    @photoset_id = params[:photoset_id]
    @photo_id = params[:photo_id]
    sizes = flickr.photos.getSizes(:photo_id => params[:photo_id])
    @photo = sizes.find {|s| s.label == 'Medium'}
    context = flickr.photosets.getContext(:photo_id => params[:photo_id], :photoset_id => params[:photoset_id])
    @next_id = context.nextphoto.id unless context.nextphoto.id == 0
    @previous_id = context.prevphoto.id unless context.prevphoto.id == 0
    display(@photo, :layout => false)
  end

  private

  def user_id
    flickr.people.findByUsername(:username => MuiFlickr[:user_name]).nsid
  end
      
end