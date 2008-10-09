require 'rubygems'

gems = %w[mui-core mui-password mui-page mui-flickr]

desc "Install the gems"
task :install do
  gems.each do |dir|
    Dir.chdir(dir){ sh 'rake install' }
  end
end

desc "Uninstall the gems"
task :uninstall do
  gems.each do |dir|
    Dir.chdir(dir){ sh 'rake uninstall' }
  end
end