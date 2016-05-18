require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'erb'
require 'uri'
require 'redcarpet'
require './config/init'

class PedalingWiki < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    @wiki = Wiki.find_wiki('대문')

    erb :'layouts/base' do |type|
      next unless @wiki
      case type
      when :stylesheet
        erb :'wikis/style'
      when :content
        erb :'wikis/show'
      end
    end
  end
end
