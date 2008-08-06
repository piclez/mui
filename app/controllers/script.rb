class MerbInterface::Script < MerbInterface::Application

  only_provides :js
  
  def index
    render
  end
  
end