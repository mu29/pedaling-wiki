ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'faker'
require 'factory_girl'
require 'shoulda'
require 'shoulda/matchers'
require 'database_cleaner'
require 'sinatra/activerecord'

Dir["./app/models/*.rb"].each{|model| require model }

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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
  end
end
