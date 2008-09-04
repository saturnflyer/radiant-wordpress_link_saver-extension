class WordpressLinkParams
  @@all = []
  
  def self.all
    @@all
  end
  
  def self.cache
    if Radiant::Config['legacy.wordpress_page_link_parameters']
      temp_arr = Radiant::Config['legacy.wordpress_page_link_parameters'].split(',')
      @@all = temp_arr.each {|p| p.strip!}
    end
  end
  
end