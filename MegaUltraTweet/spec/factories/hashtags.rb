FactoryGirl.define do
  factory :hashtag do |f|
    f.text {Faker::Lorem.word}
  end
end