class MuiPage::Pages < MuiPage::Application

  before(:mui_window_referer_create, :only => [:create, :update, :delete])
  before(:mui_password_redirect, :exclude => [:index, :read], :unless => :mui_password?)

  def index
    if Page.first
      display @pages = Page.all
    else
      session[:mui_message] = {:text => 'Create the first page.'}
      session[:mui_window] = url(:mui_page_create)
      mui_window_redirect
    end
  end

  def create
    display(@page = Page.new, :layout => false)
  end

  def create_post
    page = Page.new(params[:page])
    if page.save
      redirect(session[:mui_window_referer_read], :message => {:success => 'Page created.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_window_referer_read], :message => {:window => url(:mui_page_create), :error => error.to_s})
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
      redirect(session[:mui_window_referer_read], :message => {:success => 'Page updated.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_window_referer_read], :message => {:window => url(:mui_page_update, :id => page.id), :error => error.to_s})
    end
  end

  def delete
    display(@page = Page.get!(params[:id]), :layout => false)
  end

  def delete_put
    page = Page.get!(params[:id])
    if page.destroy
      redirect(session[:mui_window_referer_read], :message => {:success => 'Page deleted.'})
    else
      error = page.errors.each do |e|
        tag(:span, e, :class => 'error')
      end
      redirect(session[:mui_window_referer_read], :message => {:window => url(:mui_page_delete, :id => page.id), :error => error.to_s})
    end
  end

end
