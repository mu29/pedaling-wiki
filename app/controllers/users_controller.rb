class UsersController < ApplicationController
  get '/users' do
    render_template :index
  end
end
