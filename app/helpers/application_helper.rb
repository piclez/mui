module Merb::MerbInterface::ApplicationHelper

  def gecko?
    request.user_agent.include? 'Gecko/'
  end

  def msie?
    request.user_agent.include? 'MSIE'
  end

  def webkit?
    request.user_agent.include? 'AppleWebKit'
  end

  def image_path(*segments)
    public_path_for(:image, *segments)
  end

  def public_path_for(type, *segments)
    ::MerbInterface.public_path_for(type, *segments)
  end

  def app_path_for(type, *segments)
    ::MerbInterface.app_path_for(type, *segments)
  end

  def slice_path_for(type, *segments)
    ::MerbInterface.slice_path_for(type, *segments)
  end
  
end