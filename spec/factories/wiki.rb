FactoryGirl.define do
  factory :wiki do
    title Faker::Lorem.word
    content Faker::Lorem.paragraph
    created_at Time.now
    updated_at Time.now
  end
end
