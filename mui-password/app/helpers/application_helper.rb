module MuiPassword::ApplicationHelper

  def mui_password?
    session[:mui_password_id] ? true : false
  end

  def mui_password_exists?
    Password.first ? true : false
  end

  def mui_password_javascript
    tag(:script, :src => url(:mui_password_javascript), :type => 'text/javascript')
  end

  def mui_password_redirect
    if mui_password_exists?
      redirect url(:mui_password_read)
    else
      redirect url(:mui_password_create)
    end
  end
      
end

include MuiPassword::ApplicationHelper