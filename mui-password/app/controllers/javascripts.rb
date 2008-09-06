class MuiPassword::Javascripts < MuiPassword::Application

  only_provides :js
  
  def index
    render :layout => false
  end
  
end