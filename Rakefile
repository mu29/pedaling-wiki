# Rakefile
require 'bundler/setup'
require_relative 'config/init'
require 'sinatra/activerecord/rake'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)
