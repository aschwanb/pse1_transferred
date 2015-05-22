FactoryGirl.define do
  factory :webpage do |f|
    f.url {Faker::Internet.url}
    f.title {Faker::Lorem.word}
    f.description {Faker::Lorem.sentence(word_count=10)}
  end
end