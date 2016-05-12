require './app/models/User.rb'
require 'rspec'
require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe User do
  context 'validation' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  context 'association' do
    it { should have_many(:wikis) }
    it { should have_many(:replies) }
  end

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
end
