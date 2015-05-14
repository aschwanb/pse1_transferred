FactoryGirl.define do
  factory :popularity do |f|
    f.popular_id {Faker::Number.number(3)}
    f.popular_type {Faker::Lorem.word}
    #TODO improve times_used
    f.times_used ["one", "two"]
  end
end
