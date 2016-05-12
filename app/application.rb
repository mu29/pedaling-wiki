require 'sinatra'
require 'sinatra/activerecord'

Dir[ File.join( File.dirname(__FILE__), '*.rb') ].each { |f| require f }

class PedalingWiki < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
