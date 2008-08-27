class MerbInterface::Javascripts < MerbInterface::Application

  only_provides :js
  
  def page
    render
  end
  
  def dialog
    render
  end
  
end