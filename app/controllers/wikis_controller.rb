class WikisController < ApplicationController
  get '/wikis' do
    @wikis = Wiki.select("DISTINCT ON (title) *")
    render_template :index
  end

  get '/wikis/search' do
    @query = "%#{params[:query]}%"
    @wikis = Wiki.where('title LIKE ? OR content LIKE ?', @query, @query)
    render_template :search
  end

  get '/wikis/show' do
    loop do
      @id = rand(Wiki.count) + 1
      break if Wiki.exists?(@id)
    end
    title = to_url(Wiki.find(@id).title)
    redirect url("/wikis/show/#{title}")
  end

  get '/wikis/show/:title' do
    @wiki = Wiki.find_wiki(params[:title])
    if @wiki.level == 1
      render_template :show
    else
      render_template (!logged_in? || current_user.level < @wiki.level ? :permission : :show)
    end
  end

  get '/wikis/new' do
    redirect_message url('/users/login'), '로그인 후 이용해주세요.' unless logged_in?
    render_template :new
  end

  post '/wikis/new' do
    redirect_message url('/users/login'), '로그인 후 이용해주세요.' unless logged_in?
    redirect_message url('/wikis/new'), '이미 존재하는 문서입니다.' if Wiki.find_by(title: params[:title])
    redirect_message url('/wikis/new'), '내용을 모두 채워주세요.' unless params[:title].present? || params[:content].present? || params[:level].present?

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        level: params[:level],
                        user: current_user)

    title = to_url(@wiki.title)
    if @wiki.save
      redirect_message url("/wikis/show/#{title}"), '성공적으로 작성하였습니다.'
    else
      @message = '문서 생성에 실패하였습니다.'
      render_template :new
    end
  end

  get '/wikis/edit/:title' do
    redirect_message url('/users/login'), '로그인 후 이용해주세요.' unless logged_in?
    @wiki = Wiki.find_wiki(params[:title])
    render_template :edit
  end

  post '/wikis/edit' do
    redirect_message url('/users/login'), '로그인 후 이용해주세요.' unless logged_in?

    @wiki = Wiki.create(title: params[:title],
                        content: params[:content],
                        level: params[:level],
                        user: current_user)

    if @wiki.save
      redirect_message url("/wikis/show/#{to_url(@wiki.title)}"), '성공적으로 수정하였습니다.'
    else
      redirect_message url("/wikis/edit/#{to_url(@wiki.title)}"), '문서 생성에 실패하였습니다.'
    end
  end
end
