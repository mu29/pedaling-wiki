describe User do
  it "can't be created without email" do
    user = build(:user, email: nil)
    expect(user).to be_valid
  end

  it "can't be created with the same email" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email)

    expect(user1).to be_valid
    expect(user2).not_to be_valid
  end

  it "generate token" do
    user = create(:user)
    expect(user.token).not_to eq nil
  end
end
