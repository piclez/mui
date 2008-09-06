namespace :slices do
  namespace :merb_password do
  
    desc "Install MerbPassword"
    task :install => [:preflight, :setup_directories, :copy_assets, :migrate]
    
    desc "Test for any dependencies"
    task :preflight do # see slicetasks.rb
    end
    
    desc "Setup directories"
    task :setup_directories do
      puts "Creating directories for host application"
      [:application, :view, :model, :controller, :helper, :mailer, :part, :public].each do |type|
        if File.directory?(MerbPassword.dir_for(type))
          if !File.directory?(dst_path = MerbPassword.app_dir_for(type))
            relative_path = dst_path.relative_path_from(Merb.root)
            puts "- creating directory :#{type} #{File.basename(Merb.root) / relative_path}"
            mkdir_p(dst_path)
          end
        end
      end
    end
    
    desc "Copy stub files to host application"
    task :stubs do
      puts "Copying stubs for MerbPassword - resolves any collisions"
      copied, preserved = MerbPassword.mirror_stubs!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Copy stub files and views to host application"
    task :patch => [ "stubs", "freeze:views" ]
    
    desc "Copy public assets to host application"
    task :copy_assets do
      puts "Copying assets for MerbPassword - resolves any collisions"
      copied, preserved = MerbPassword.mirror_public!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Migrate the database"
    task :migrate do # see slicetasks.rb
    end
    
    desc "Freeze MerbPassword into your app (only merb_id/app)" 
    task :freeze => [ "freeze:app" ]

    namespace :freeze do
      
      desc "Freezes MerbPassword by installing the gem into application/gems using merb-freezer"
      task :gem do
        begin
          Object.const_get(:Freezer).freeze(ENV["GEM"] || "merb_id", ENV["UPDATE"], ENV["MODE"] || 'rubygems')
        rescue NameError
          puts "! dependency 'merb-freezer' missing"
        end
      end
      
      desc "Freezes MerbPassword by copying all files from merb_id/app to your application"
      task :app do
        puts "Copying all merb_id/app files to your application - resolves any collisions"
        copied, preserved = MerbPassword.mirror_app!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all views into your application for easy modification" 
      task :views do
        puts "Copying all view templates to your application - resolves any collisions"
        copied, preserved = MerbPassword.mirror_files_for :view
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all models into your application for easy modification" 
      task :models do
        puts "Copying all models to your application - resolves any collisions"
        copied, preserved = MerbPassword.mirror_files_for :model
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freezes MerbPassword as a gem and copies over merb_id/app"
      task :app_with_gem => [:gem, :app]
      
      desc "Freezes MerbPassword by unpacking all files into your application"
      task :unpack do
        puts "Unpacking MerbPassword files to your application - resolves any collisions"
        copied, preserved = MerbPassword.unpack_slice!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
    end
    
  end
end