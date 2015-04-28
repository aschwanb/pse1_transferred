FactoryGirl.define do
  factory :trending do |f|
    f.id {Faker::Number.number(3)}
    f.created_at DateTime.new(2001,1,2)
    f.updated_at DateTime.new(2001,1,2)
  end
end
