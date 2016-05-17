require './app/application'
require './app/controllers/application_controller'

# models
Dir['./app/models/*.rb'].each { |model| require model }

# controllers
Dir['./app/controllers/*.rb'].each { |controller| require controller }
