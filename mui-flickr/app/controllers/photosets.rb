class MuiFlickr::Photosets < MuiFlickr::Application

  load_dependency 'flickraw'
  
  FlickRaw.api_key = MuiFlickr[:api_key]
  FlickRaw.shared_secret = MuiFlickr[:shared_secret]

  @flickr_user_name = MuiFlickr[:user_name]
  
  def index
    @photosets = flickr.photosets.getList :user_id => user_id
    display @photosets
  end

  def photoset
    @photos = flickr.photosets.getPhotos(:photoset_id => params[:id]).photo
    @photoset = flickr.photosets.getInfo(:photoset_id => params[:id])
    display @photos
  end

  def photo
    photoset_id = flickr.photos.getAllContexts(:photo_id => params[:id]).first.id
    context = flickr.photosets.getContext(:photo_id => params[:id], :photoset_id => photoset_id)
    @next = context.nextphoto unless context.nextphoto.id == 0
    @photoset = flickr.photosets.getInfo(:photoset_id => photoset_id)
    @previous = context.prevphoto unless context.prevphoto.id == 0
    @photo = flickr.photos.getInfo(:photo_id => params[:id], :secret => params[:secret])
    @photo.title << 'Untitled' if @photo.title == ''
#      if @photo.comments.to_i > 0
#        @comments = flickr.photos.comments.getList(:photo_id => params[:id])
#      end
    @size = flickr.photos.getSizes(:photo_id => params[:id]).last
    display @photo
  end

  private

  def user_id
    flickr.people.findByUsername(:username => MuiFlickr[:user_name]).nsid
  end
      
end