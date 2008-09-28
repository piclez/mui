module MuiPassword::MuiPasswords

  def mui_password?
    session[:mui_password_id] ? true : false
  end

  def mui_password_exists?
    Password.first ? true : false
  end

  def mui_javascript_password
    tag(:script, :src => url(:mui_javascript_password), :type => 'text/javascript')
  end

  def mui_password_redirect
    if mui_password_exists?
      redirect url(:mui_password_read)
    else
      redirect url(:mui_password_create)
    end
  end
      
end

include MuiPassword::MuiPasswords