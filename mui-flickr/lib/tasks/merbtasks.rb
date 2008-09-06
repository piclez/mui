namespace :slices do
  namespace :mui_flickr do
  
    desc "Install Merb Flickr"
    task :install => [:preflight, :setup_directories, :copy_assets, :migrate]
    
    desc "Test for any dependencies"
    task :preflight do # see slicetasks.rb
    end
    
    desc "Setup directories"
    task :setup_directories do
      puts "Creating directories for host application"
      [:application, :view, :model, :controller, :helper, :mailer, :part, :public].each do |type|
        if File.directory?(MuiFlickr.dir_for(type))
          if !File.directory?(dst_path = MuiFlickr.app_dir_for(type))
            relative_path = dst_path.relative_path_from(Merb.root)
            puts "- creating directory :#{type} #{File.basename(Merb.root) / relative_path}"
            mkdir_p(dst_path)
          end
        end
      end
    end
    
    desc "Copy stub files to host application"
    task :stubs do
      puts "Copying stubs for MuiFlickr - resolves any collisions"
      copied, preserved = MuiFlickr.mirror_stubs!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Copy stub files and views to host application"
    task :patch => [ "stubs", "freeze:views" ]
    
    desc "Copy public assets to host application"
    task :copy_assets do
      puts "Copying assets for MuiFlickr - resolves any collisions"
      copied, preserved = MuiFlickr.mirror_public!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Migrate the database"
    task :migrate do # see slicetasks.rb
    end
    
    desc "Freeze MuiFlickr into your app (only merb_flickr/app)" 
    task :freeze => [ "freeze:app" ]

    namespace :freeze do
      
      desc "Freezes MuiFlickr by installing the gem into application/gems using merb-freezer"
      task :gem do
        begin
          Object.const_get(:Freezer).freeze(ENV["GEM"] || "merb_flickr", ENV["UPDATE"], ENV["MODE"] || 'rubygems')
        rescue NameError
          puts "! dependency 'merb-freezer' missing"
        end
      end
      
      desc "Freezes MuiFlickr by copying all files from merb_flickr/app to your application"
      task :app do
        puts "Copying all merb_flickr/app files to your application - resolves any collisions"
        copied, preserved = MuiFlickr.mirror_app!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all views into your application for easy modification" 
      task :views do
        puts "Copying all view templates to your application - resolves any collisions"
        copied, preserved = MuiFlickr.mirror_files_for :view
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all models into your application for easy modification" 
      task :models do
        puts "Copying all models to your application - resolves any collisions"
        copied, preserved = MuiFlickr.mirror_files_for :model
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freezes MuiFlickr as a gem and copies over merb_flickr/app"
      task :app_with_gem => [:gem, :app]
      
      desc "Freezes MuiFlickr by unpacking all files into your application"
      task :unpack do
        puts "Unpacking MuiFlickr files to your application - resolves any collisions"
        copied, preserved = MuiFlickr.unpack_slice!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
    end
    
  end
end