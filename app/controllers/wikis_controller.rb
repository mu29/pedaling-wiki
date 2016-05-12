class WikisController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/wikis' do
    'wikis'
  end
end
