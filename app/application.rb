require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require './config/init'

class PedalingWiki < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    halt 200, 'hi'
  end
end
