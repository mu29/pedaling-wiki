describe 'User Controller' do
  def app
    UsersController.new
  end

  before(:each) do
    @user = create(:user)
  end

  it 'can be login with email and password' do
    post '/users/login', { email: @user.email, password: @user.password }
    puts last_response.body
    expect(last_response.status).to eq 302
    expect(session[:token]).not_to be_nil
  end

  it "can't be register with same email" do
    expect {
      post '/users/register', { email: @user.email, name: @user.name, password: @user.password }
    }.to change(User, :count).by(0)
    expect(last_response).to be_ok
    expect(last_response.body).to include('이미 가입된 메일 주소입니다.')
  end
end
