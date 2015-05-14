FactoryGirl.define do
  factory :author do |f|
    f.name {Faker::Name.name}
    f.twitter_id {Faker::Number.number(8)}
    f.friends_count {Faker::Number.number(4)}
    f.followers_count {Faker::Number.number(4)}
    f.screen_name {Faker::Name.name}
  end
end