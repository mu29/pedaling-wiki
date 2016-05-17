class UsersController < ApplicationController
  get '/users' do
    render_template :index
  end

  get '/users/new' do
    render_template :new
  end

  get '/users/login' do
    render_template :login
  end
end
