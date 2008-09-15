module Merb::MuiCore::MuiUserAgents

  def mui_gecko?
    request.user_agent.include? 'Gecko/'
  end

  def mui_msie?
    request.user_agent.include? 'MSIE'
  end

  def mui_webkit?
    request.user_agent.include? 'AppleWebKit'
  end

end

include Merb::MuiCore::MuiUserAgents