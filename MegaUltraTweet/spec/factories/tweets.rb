FactoryGirl.define do
  factory :tweet do |f|
    f.text {Faker::Lorem.sentence(word_count=30)}
    f.retweets {Faker::Number.number(4)}
    f.twitter_id {Faker::Number.number(8)}
    f.author_id {Faker::Number.number(4)}
  end
end