describe Wiki do
  it "can't be created without user" do
    wiki = build(:wiki)
    expect(wiki).not_to be_valid
  end

  it 'generate version' do
    wiki = create(:wiki, user: create(:user))
    wiki2 = create(:wiki, title: wiki.title, user: wiki.user)
    expect(wiki2.version).to eq 2
  end
end
