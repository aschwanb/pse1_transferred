FactoryGirl.define do
  factory :author do |f|
    f.id {Faker::Number.number(3)}
    f.name {Faker::Name.name}
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
    f.twitter_id {Faker::Number.number(8)}
    f.friends_count {Faker::Number.number(4)}
    f.followers_count {Faker::Number.number(4)}
    f.screen_name {Faker::Name.name}
  end
end