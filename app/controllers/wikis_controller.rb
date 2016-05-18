class WikisController < ApplicationController
  get '/wikis' do
    @wikis = Wiki.all.order('created_at DESC')
    render_template :index
  end

  get '/wikis/show' do
    title = URI.escape(Wiki.find(rand(Wiki.count) + 1).title)
    redirect url("/wikis/show/#{title}")
  end

  get '/wikis/show/:title' do
    @wiki = Wiki.find_wiki(params[:title])
    render_template :show
  end

  get '/wikis/new' do
    render_template :new
  end

  post '/wikis/new' do
    unless logged_in?
      redirect_message url('/users/login'), '로그인 후 이용해주세요.'
    end

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        user: current_user)

    title = URI.escape(@wiki.title)
    if @wiki.save
      redirect_message url("/wikis/show/#{title}"), '성공적으로 작성하였습니다.'
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
    redirect_message url('/users/login'), '로그인 후 이용해주세요.' unless logged_in?

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        user: current_user)

    title = URI.escape(@wiki.title)
    if @wiki.save
      redirect_message url("/wikis/show/#{title}"), '성공적으로 수정하였습니다.'
    else
      redirect_message url("/wikis/edit/#{title}"), '문서 생성에 실패하였습니다.'
    end
  end
end
