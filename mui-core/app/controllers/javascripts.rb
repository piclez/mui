class MuiCore::Javascripts < MuiCore::Application

  only_provides :js
  
  def desktop
    render :layout => false
  end
  
  def message
    render :layout => false
  end
  
  def window
    render :layout => false
  end
  
end