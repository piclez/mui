class MuiPassword::Javascripts < MuiPassword::Application

  only_provides :js
  
  def password
    render :layout => false
  end
  
end