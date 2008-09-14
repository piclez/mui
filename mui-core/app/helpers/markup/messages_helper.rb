module Merb::MuiCore::MessagesHelper

  def mui_message(message = {})
    html = ''
    if message[:error]
      script_content = "$(document).ready(function(){"
      script_content << "$('.mui_window_target').hide().load('#{message[:error]}').fadeIn();"
      script_content << "});"
      html << tag(:script, script_content, :type => 'text/javascript')
    end
    if message[:success]
      script_content = "$(document).ready(function(){"
      script_content << "$('.mui_window_target').hide().load('#{message[:success]}').fadeIn();"
      script_content << "});"
      html << tag(:script, script_content, :type => 'text/javascript')
    end
    html
  end

end

include Merb::MuiCore::MessagesHelper
