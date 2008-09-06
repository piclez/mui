class MuiPage::Pages < MuiPage::Application

  before(:mui_password_referer, :only => [:create, :update, :delete])
  before(:mui_password_redirect, :exclude => [:index, :read], :unless => :mui_password?)

  def index
    if Page.first
      display @pages = Page.all
    else
      redirect(session[:page], :message => {:dialog => url(:mui_page_create), :notice => 'Create the first page.'})
    end
  end

  def create
    display(@page = Page.new, :layout => false)
  end

  def create_post
    page = Page.new(params[:page])
    if page.save
      redirect(session[:page], :message => {:success => 'Page created.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:page], :message => {:dialog => url(:mui_page_create), :error => error.to_s})
    end
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
      redirect(session[:page], :message => {:success => 'Page updated.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:page], :message => {:dialog => url(:mui_page_update, :id => page.id), :error => error.to_s})
    end
  end

  def delete
    display(@page = Page.get!(params[:id]), :layout => false)
  end

  def delete_put
    page = Page.get!(params[:id])
    if page.destroy
      redirect(session[:page], :message => {:success => 'Page deleted.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:page], :message => {:dialog => url(:mui_page_delete, :id => page.id), :error => error.to_s})
    end
  end

end
