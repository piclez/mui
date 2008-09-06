class MuiCore::Javascripts < MuiCore::Application

  only_provides :js
  
  def index
    render :layout => false
  end
  
  def dialog
    render :layout => false
  end
  
end