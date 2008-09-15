class MuiCore::Messages < MuiCore::Application

  def index
    @message = session[:mui_message]
    session.delete(:mui_message)
    display(@message, :layout => false)
  end
  
end