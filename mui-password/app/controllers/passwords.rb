class MuiPassword::Passwords < MuiPassword::Application

  before(:mui_window_referer_create, :only => [:exit, :create, :read, :update, :delete])
  before(:mui_password_redirect, :exclude => [:exit, :create, :read], :unless => :mui_password?)
  
  def exit
    session.delete(:mui_password_id)
    session[:mui_message] = {:text => 'Exited.', :tone => 'positive'}
    mui_window_redirect
  end

  def create
    display(@password = Password.new, :layout => false)
  end

  def create_post
    password = Password.new(params[:password])
    if password.save
      session[:mui_password_id] = password.id
      session[:mui_message] = {:text => 'Password created.', :tone => 'positive'}
      mui_window_redirect
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_password_create)
      mui_window_redirect
    end
  end

  def read
    if mui_password_exists?
      display(@password = Password.new, :layout => false)
    else
      redirect url(:mui_password_create)
    end
  end

  def read_post
    encrypted = encrypt(params[:password])
    if password_match = Password.first(:encrypted => encrypted)
      session[:mui_password_id] = password_match.id
      session[:mui_message] = {:text => 'Password correct.', :tone => 'positive'}
    else
      session[:mui_message] = {:text => 'Password incorrect.', :tone => 'negative'}
      session[:mui_window] = url(:mui_password_read)
    end
    mui_window_redirect
  end

  def update
    display(@password = Password.new, :layout => false)
  end

  def update_post
    password = Password.get!(session[:password_id])
    if password.update_attributes(params[:password])
      session[:mui_message] = {:text => 'Password updated.', :tone => 'positive'}
      mui_window_redirect
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_password_update)
      mui_window_redirect
    end
  end

  def delete
    render :layout => false
  end

  def delete_post
    password = Password.get!(session[:mui_password_id])
    if password.destroy
      session.delete(:mui_password_id)
      session[:mui_message] = {:text => 'Password deleted.', :tone => 'positive'}
      mui_window_redirect
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_password_delete)
      mui_window_redirect
    end
  end

  protected
  
  require "digest/sha1"

  def encrypt(password)
    Digest::SHA1.hexdigest("--#{password[:password]}--")
  end

end
