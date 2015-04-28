FactoryGirl.define do
  factory :hashtag do |f|
    f.id {Faker::Number.number(3)}
    f.text {Faker::Lorem.word}
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
  end
end