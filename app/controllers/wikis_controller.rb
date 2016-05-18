class WikisController < ApplicationController
  get '/wikis' do
    render_template :index
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
      redirect url("/users/wikis/#{title}")
    else
      @message = '문서 생성에 실패하였습니다.'
      render_template :new
    end
  end
end
