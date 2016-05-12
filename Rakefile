# Rakefile
require 'sinatra/activerecord/rake'
require 'rspec/core'
require 'rspec/core/rake_task'

namespace :db do
  task :load_config do
    require './app/application'
  end
end

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)
