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

end