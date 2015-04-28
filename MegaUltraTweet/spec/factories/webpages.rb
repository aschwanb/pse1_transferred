FactoryGirl.define do
  factory :webpage do |f|
    f.id {Faker::Number.number(3)}
    f.url {Faker::Internet.url}
    f.title {Faker::Lorem.word}
    f.description {Faker::Lorem.sentence(word_count=10)}
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
  end
end