class UsersController < ApplicationController
  get '/users/login' do
    redirect_message url('/'), '이미 로그인 했자나요.' if logged_in?
    render_template :login
  end

  post '/users/login' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user.present?
      session[:token] = @user.token
      redirect url('/')
    else
      @message = '아이디와 비밀번호를 확인해주세요.'
      render_template :login
    end
  end

  get '/users/register' do
    redirect_message url('/'), '이미 로그인 했자나요.' if logged_in?
    render_template :register
  end

  post '/users/register' do
    @user = User.create(email: params[:email],
                        name: params[:name],
                        password: params[:password])

    if @user.save
      redirect_message url('/users/login'), '성공적으로 가입하였습니다.'
    else
      @message = '이미 가입된 메일 주소입니다.'
      render_template :register
    end
  end
end
