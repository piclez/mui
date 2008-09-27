class MuiPage::Pages < MuiPage::Application

  before(:mui_window_referer, :only => [:create, :update, :delete])
  before(:mui_password_redirect, :exclude => [:index, :read], :unless => :mui_password?)

  def index
    if Page.first
      display @pages = Page.all
    else
      session[:mui_message] = {:title => 'Create the first page'}
      session[:mui_window] = url(:mui_page_create)
      render
    end
  end

  def create
    display(@page = Page.new, :layout => false)
  end

  def create_post
    page = Page.new(params[:page])
    if page.save
      session[:mui_message] = {:title => 'Page created', :tone => 'positive'}
    else
      session[:mui_message] = {:title => 'Unable to create page', :body => mui_list(password.errors), :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

  def read
    display @page = Page.get!(params[:page_id])
  end

  def update
    display(@page = Page.get!(params[:page_id]), :layout => false)
  end

  def update_put
    page = Page.get!(params[:page_id])
    if page.update_attributes(params[:page])
      session[:mui_message] = {:title => 'Page updated', :tone => 'positive'}
    else
      session[:mui_message] = {:title => 'Unable to update page', :body => mui_list(password.errors), :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

  def delete
    display(@page = Page.get!(params[:page_id]), :layout => false)
  end

  def delete_put
    page = Page.get!(params[:page_id])
    if page.destroy
      session[:mui_message] = {:title => 'Page deleted', :tone => 'positive'}
    else
      session[:mui_message] = {:title => 'Unable to delete page', :body => mui_list(password.errors), :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

end
