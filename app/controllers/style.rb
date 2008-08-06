class MerbInterface::Style < MerbInterface::Application

  only_provides :css

  def index
    render
  end
  
end