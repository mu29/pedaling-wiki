describe 'Wiki Controller' do
  def app
    WikisController.new
  end

  before(:each) do
    @user = create(:user)
    @wiki = create(:wiki, user: @user)
  end

  it 'get list of wikis' do
    10.times { create(:wiki, user: @user) }
    get '/wikis'
    expect(last_response).to be_ok
    expect(last_response.body).to include(@wiki.title)
  end

  it 'show wiki' do
    get "/wikis/show/#{@wiki.title}"
    expect(last_response).to be_ok
    expect(last_response.body).to include(@wiki.title)
  end

  it "can't create wiki without logged in" do
    expect {
      post '/wikis/new',
           { title: Faker::Lorem.word, content: Faker::Lorem.paragraph }
    }.to change(Wiki, :count).by(0)
  end

  it "can't create wiki with same title" do
    expect {
      post '/wikis/new',
           { title: @wiki.title, content: Faker::Lorem.paragraph },
           { 'rack.session' => { token: @user.token } }
    }.to change(Wiki, :count).by(0)
    expect(last_response.status).to eq 302
  end

  it 'create wiki with token' do
    expect {
      post '/wikis/new',
           { title: Faker::Lorem.word, content: Faker::Lorem.paragraph },
           { 'rack.session' => { token: @user.token } }
    }.to change(Wiki, :count).by(1)
  end

  it "can't edit wiki without logged in" do
    expect {
      post '/wikis/edit',
           { title: @wiki.title, content: Faker::Lorem.paragraph }
    }.to change(Wiki, :count).by(0)
  end

  it 'edit wiki with token' do
    expect {
      post '/wikis/edit',
           { title: @wiki.title, content: Faker::Lorem.paragraph },
           { 'rack.session' => { token: @user.token } }
    }.to change(Wiki, :count).by(1)
    expect(@wiki.version + 1).to eq Wiki.find_wiki(@wiki.title).version
  end
end
