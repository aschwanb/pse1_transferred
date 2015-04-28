FactoryGirl.define do
  factory :popularity do |f|
    f.id {Faker::Number.number(3)}
    f.popular_id {Faker::Number.number(3)}
    f.popular_type {Faker::Lorem.word}
    #TODO improve times_used
    f.times_used ["one", "two"]
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
  end
end
