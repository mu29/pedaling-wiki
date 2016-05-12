ENV['RACK_ENV'] = 'test'

require './config/init'
require 'rspec'
require 'rack/test'
require 'faker'
require 'factory_girl'
require 'shoulda'
require 'database_cleaner'
require 'simplecov'

SimpleCov.start do
  add_filter '/db/'
  add_filter '/config/'
  add_filter '/app/'
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
