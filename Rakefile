module Mui
  VERSION = '1.0'
end

AUTHOR = 'Jamie Hoover'
DESCRIPTION = 'Merb User Interface'
EMAIL  = 'dont.tase@me.com'
NAME = 'mui'
URL = 'http://uipoet.com/'

require 'rake/clean'
require 'rake/gempackagetask'
require 'merb-core/tasks/merb_rake_helper'
require 'fileutils'
include FileUtils

gems = %w[mui-core mui-password mui-page mui-flickr]

mui_spec = Gem::Specification.new do |s|
  s.rubyforge_project = NAME
  s.name         = NAME
  s.version      = Mui::VERSION
  s.platform     = Gem::Platform::RUBY
  s.author       = AUTHOR
  s.email        = EMAIL
  s.homepage     = URL
  s.summary      = DESCRIPTION
  s.description  = DESCRIPTION
  s.files        = %w( LICENSE README Rakefile lib/mui.rb )
  gems.each do |gem|
    s.add_dependency gem, [">= #{Mui::VERSION}", '<= 1.0']
  end
end

CLEAN.include ['**/.*.sw?', 'pkg', 'lib/*.bundle', '*.gem', 'doc/rdoc', '.config', 'coverage', 'cache', 'lib/mui.rb']

Rake::GemPackageTask.new(mui_spec) do |package|
  package.gem_spec = mui_spec
end

gem_home = ENV['GEM_HOME'] ? "GEM_HOME=#{ENV['GEM_HOME']}" : ""

desc 'Install it all'
task :install => [:install_gems, :package] do
  sh %{#{sudo} gem install #{install_home} --local pkg/mui-#{Mui::VERSION}.gem --no-update-sources}
end

desc 'Build the mui gems'
task :build_gems do
  gems.each do |dir|
    Dir.chdir(dir){ sh 'rake package' }
  end
end

desc 'Install the mui sub-gems'
task :install_gems do
  gems.each do |dir|
    Dir.chdir(dir){ sh 'rake install' }
  end
end

desc 'Uninstall the mui sub-gems'
task :uninstall_gems do
  gems.each do |sub_gem|
    sh %{#{sudo} gem uninstall #{sub_gem}}
  end
end

desc 'Clobber the mui sub-gems'
task :clobber_gems do
  gems.each do |gem|
    Dir.chdir(gem){ sh 'rake clobber' }
  end
end

task :package => ['lib/mui.rb']
desc 'Create mui.rb'
task 'lib/mui.rb' do
  mkdir_p 'lib'
  File.open('lib/mui.rb','w+') do |file|
    file.puts '# DO NOT EDIT: Automatically Generated'
    gems.each do |gem|
      file.puts "require '#{gem}'"
    end
  end
end

desc 'Bundle up all the mui gems'
task :bundle => [:package, :build_gems] do
  mkdir_p 'bundle'
  cp "pkg/mui-#{VERSION}.gem", 'bundle'
  gems.each do |gem|
    sh %{cp #{gem}/pkg/#{gem}-#{Mui::VERSION}.gem bundle/}
  end
end

PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_VERSION   = VERSION + PKG_BUILD
RELEASE_NAME  = "REL #{PKG_VERSION}"

namespace :release do
  desc 'Publish Merb UI release files to RubyForge.'
  task :mui => [ :package ] do
    require 'rubyforge'
    require 'rake/contrib/rubyforgepublisher'
 
    packages = %w( gem tgz zip ).collect{ |ext| "pkg/mui-more-#{PKG_VERSION}.#{ext}" }
 
    begin
      sh %{rubyforge login}
      sh %{rubyforge add_release #{NAME} mui #{Mui::VERSION} #{packages.join(' ')}}
      sh %{rubyforge add_file #{NAME} mui #{Mui::VERSION} #{packages.join(' ')}}
    rescue Exception => e
      puts
      puts "Release failed: #{e.message}"
      puts
      puts 'Set PKG_BUILD environment variable if you do a subrelease (1.0.1.2008_08_02 when version is 1.0.1)'
    end
  end

  desc 'Publish Merb UI gems to RubyForge, one by one.'
  task :mui_gems => [ :build_gems ] do
    gems.each do |gem|
      Dir.chdir(gem){ sh 'rake release' }
    end
  end

end