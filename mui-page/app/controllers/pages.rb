class MuiPage::Pages < MuiPage::Application

  before(:mui_window_referer, :only => [:create, :update, :delete])
  before(:mui_password_redirect, :exclude => [:index, :read], :unless => :mui_password?)

  def index
    if Page.first
      display @pages = Page.all
    else
      session[:mui_message] = {:text => 'Create the first page.'}
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
      session[:mui_message] = {:text => 'Page created.', :tone => 'positive'}
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

  def read
    display @page = Page.get!(params[:id])
  end

  def update
    display(@page = Page.get!(params[:id]), :layout => false)
  end

  def update_put
    page = Page.get!(params[:id])
    if page.update_attributes(params[:page])
      session[:mui_message] = {:text => 'Page updated.', :tone => 'positive'}
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

  def delete
    display(@page = Page.get!(params[:id]), :layout => false)
  end

  def delete_put
    page = Page.get!(params[:id])
    if page.destroy
      session[:mui_message] = {:text => 'Page deleted.', :tone => 'positive'}
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      session[:mui_message] = {:text => error.to_s, :tone => 'negative'}
      session[:mui_window] = url(:mui_page_create)
    end
    mui_window_redirect
  end

end
