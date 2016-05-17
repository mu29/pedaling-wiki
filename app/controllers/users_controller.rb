class UsersController < ApplicationController
  get '/users' do
    render_template :index
  end

  get '/users/login' do
    render_template :login
  end

  post '/users/login' do
    if User.find_by(email: params[:email], password: params[:password])
      session[:email] = session[:email]
      redirect url('/')
    else
      @message = '아이디와 비밀번호를 확인해주세요.'
      render_template :login
    end
  end

  get '/users/register' do
    render_template :register
  end

  post '/users/register' do
    @user = User.create(email: params[:email],
                        name: params[:name],
                        password: params[:password])

    if @user.save
      redirect url('/users/login')
    else
      @message = '이미 가입된 메일 주소입니다.'
      render_template :register
    end
  end
end
