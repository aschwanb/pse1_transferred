FactoryGirl.define do
  factory :author_hashtag do |f|
    f.id {Faker::Number.number(3)}
    f.author_id {Faker::Number.number(4)}
    f.hashtag_id {Faker::Number.number(4)}
  end
end