FactoryGirl.define do
  factory :hashtag_hashtag do |f|
    f.hashtag_first_id {Faker::Number.number(4)}
    f.hashtag_second_id {Faker::Number.number(4)}
  end
end