require './app/application'

# models
Dir['./app/models/*.rb'].each { |model| require model }

# controllers
Dir['./app/controllers/*.rb'].each { |controller| require controller }

# logger
enable :logging
