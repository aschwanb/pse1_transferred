FactoryGirl.define do
  factory :popularity do |f|
    f.popular_id {Faker::Number.number(3)}
    f.popular_type {Faker::Lorem.word}
    f.times_used [10, 20]
  end
end
