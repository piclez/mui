class MuiFlickr::Stylesheets < MuiFlickr::Application

  only_provides :css

  def flickr
    render :layout => false
  end
  
end