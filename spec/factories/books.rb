FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| Faker::Lorem.sentence + n.to_s }
  end

end
