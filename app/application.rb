require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'erb'
require './config/init'

class PedalingWiki < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    erb :'layouts/base' do
      erb '<b>흐앙</b>'
    end
  end
end
