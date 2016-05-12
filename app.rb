require 'sinatra'
require 'sinatra/activerecord'

class PedalingWiki < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
