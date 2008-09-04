module WordpressLinkSaver::SiteControllerExtensions
  def self.included(base)
    base.class_eval { alias_method_chain :show_page, :wordpress_links }
  end

  def show_page_with_wordpress_links
    WordpressLinkParams.all.each do |wp_param|
      if params[wp_param.to_sym]        
        page = Page.find_by_wordpress_id(params[:p])
        url = page.url
        location = url_for(:controller => 'site', :action => 'show_page', :url => url)
        redirect_to location, :status => "301 Moved Permanently"
      else
        show_page_without_wordpress_links
      end
    end
  end
end