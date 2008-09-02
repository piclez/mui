require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'merb-core/version'
require 'merb-core/tasks/merb_rake_helper'
require 'merb-core/test/tasks/spectasks'

NAME = "merb-interface"
AUTHOR = "Jamie Hoover"
EMAIL = "dont.tase@me.com"
HOMEPAGE = "http://uipoet.com/"
SUMMARY = "Interface"
GEM_VERSION = "0.9.5"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb-interface'
  s.name = NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-slices', '>= 0.9.5')
  s.add_dependency('merb_helpers', '>= 0.9.5')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{lib,app,public}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install Interface as a gem"
task :install => [:package] do
  sh %{#{sudo} gem install pkg/#{NAME}-#{GEM_VERSION} --no-update-sources}
end

namespace :jruby do

  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{sudo} jruby -S gem install #{install_home} pkg/#{NAME}-#{GEM_VERSION}.gem --no-rdoc --no-ri}
  end
  
end