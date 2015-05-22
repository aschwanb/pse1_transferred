FactoryGirl.define do
  factory :author_hashtag do |f|
    f.author_id {Faker::Number.number(4)}
    f.hashtag_id {Faker::Number.number(4)}
    f.new_short true
    f.new_long true
  end
end