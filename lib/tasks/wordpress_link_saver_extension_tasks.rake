namespace :radiant do
  namespace :extensions do
    namespace :wordpress_link_saver do
      
      desc "Runs the migration of the Wordpress Link Saver extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          WordpressLinkSaverExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          WordpressLinkSaverExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Wordpress Link Saver to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[WordpressLinkSaverExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(WordpressLinkSaverExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
