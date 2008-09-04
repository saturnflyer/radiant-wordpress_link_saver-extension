require_dependency 'application'

class WordpressLinkSaverExtension < Radiant::Extension
  version "1.0"
  description "Collects links from former WordPress articles and routes them to the appropriate page."
  url "http://saturnflyer.com/"
  
  def activate
    Radiant::Config['legacy.wordpress_page_link_parameters'] = 'p, page_id' unless Radiant::Config['legacy.wordpress_page_link_parameters']
    WordpressLinkParams.cache
    SiteController.send :include, WordpressLinkSaver::SiteControllerExtensions
  end
  
  def deactivate
    
  end
  
end