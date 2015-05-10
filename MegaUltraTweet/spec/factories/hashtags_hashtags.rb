FactoryGirl.define do
  factory :hashtag_hashtag do |f|
    f.id {Faker::Number.number(3)}
    f.hashtag_first_id {Faker::Number.number(4)}
    f.hashtag_second_id {Faker::Number.number(4)}
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
  end
end