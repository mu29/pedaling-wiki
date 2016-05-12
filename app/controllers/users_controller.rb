class UsersController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/users' do
    'users'
  end
end
