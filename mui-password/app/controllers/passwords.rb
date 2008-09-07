class MuiPassword::Passwords < MuiPassword::Application

  before(:mui_password_referer, :only => [:create, :read, :update, :delete])
  before(:mui_password_redirect, :exclude => [:create, :read], :unless => :mui_password?)
  
  def create
    display(@password = Password.new, :layout => false)
  end

  def create_post
    password = Password.new(params[:password])
    if password.save
      session[:mui_password_id] = password.id
      redirect(session[:mui_password_referer], :message => {:success => 'Password created.'})
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_password_referer], :message => {:dialog => url(:mui_password_create), :error => error.to_s})
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
      redirect(session[:mui_password_referer], :message => {:success => 'Password correct.'})
    else
      redirect(session[:mui_password_referer], :message => {:dialog => url(:mui_password_read), :error => 'Password incorrect.'})
    end
  end

  def update
    display(@password = Password.new, :layout => false)
  end

  def update_post
    password = Password.get!(session[:password_id])
    if password.update_attributes(params[:password])
      redirect(session[:mui_password_referer], :message => {:success => 'Password updated.'})
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_password_referer], :message => {:dialog => url(:mui_password_update), :error => error.to_s})
    end
  end

  def delete
    render :layout => false
  end

  def delete_post
    password = Password.get!(session[:password_id])
    if password.destroy
      session.delete(:password_id)
      redirect(session[:mui_password_referer], :message => {:success => 'Password deleted.'})
    else
      error = password.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_password_referer], :message => {:dialog => url(:mui_password_delete), :error => error})
    end
  end

  protected
  
  require "digest/sha1"

  def encrypt(password)
    Digest::SHA1.hexdigest("--#{password[:password]}--")
  end

end
