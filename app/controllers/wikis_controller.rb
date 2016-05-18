class WikisController < ApplicationController
  get '/wikis/show' do
    title = URI.escape(Wiki.find(rand(Wiki.count) + 1).title)
    redirect url("/wikis/show/#{title}")
  end

  get '/wikis/show/:title' do
    @wiki = Wiki.where(title: params[:title]).order('created_at DESC').first
    render_template :show
  end

  get '/wikis/new' do
    render_template :new
  end

  post '/wikis/new' do
    redirect url('/users/login') unless logged_in?

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        user: current_user)

    title = URI.escape(@wiki.title)
    if @wiki.save
      redirect url("/wikis/show/#{title}")
    else
      @message = '문서 생성에 실패하였습니다.'
      render_template :new
    end
  end

  get '/wikis/edit/:title' do
    @wiki = Wiki.where(title: params[:title]).order('created_at DESC').last
    render_template :edit
  end

  post '/wikis/edit' do
    redirect url('/users/login') unless logged_in?

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        user: current_user)

    title = URI.escape(@wiki.title)
    if @wiki.save
      redirect url("/wikis/show/#{title}")
    else
      @message = '문서 생성에 실패하였습니다.'
      render_template :new
    end
  end
end
