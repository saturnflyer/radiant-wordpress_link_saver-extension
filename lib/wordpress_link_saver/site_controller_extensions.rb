module WordpressLinkSaver::SiteControllerExtensions
  def self.included(base)
    base.class_eval { alias_method_chain :show_page, :wordpress_links }
  end

  def show_page_with_wordpress_links
    action = lambda {show_page_without_wordpress_links}
    WordpressLinkParams.all.each do |wp_param|
      parameter = params[wp_param.to_sym]
      if parameter
        string_parameter = (parameter.to_i == 0)
        page = Page.find_by_wordpress_id(parameter)
        if page
          action = lambda {redirect_to page.url, redirect_options and return}
        elsif page.nil? and Object.const_defined?(:TagsExtension) and string_parameter
          results_page_url = Radiant::Config['tags.results_page_url'] || '/'
          page = Page.find_by_url(results_page_url)
          action = lambda {redirect_to url_for(:url => page.url.gsub(/^\//,''), :tag => parameter), :status => "301 Moved Permanently" and return}
        else
          page = FileNotFoundPage.find(:first)
          action = lambda {redirect_to page.url and return}
        end
      end
    end
    action.call
  end
end