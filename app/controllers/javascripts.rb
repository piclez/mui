class MerbInterface::Javascripts < MerbInterface::Application

  only_provides :js
  
  def interface
    render
  end
  
end