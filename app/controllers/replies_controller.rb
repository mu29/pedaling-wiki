class RepliesController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/replies' do
    'replies'
  end
end
