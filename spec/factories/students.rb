FactoryGirl.define do
  factory :student do
    sequence(:name) { |n| "student#{n}" }
    sequence(:contact) { |n| "student#{n}@example.com" }
  end

end
