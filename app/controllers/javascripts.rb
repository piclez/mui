class MerbInterface::Javascripts < MerbInterface::Application

  only_provides :js
  
  def page
    render :layout => false
  end
  
  def dialog
    render :layout => false
  end
  
end