FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    sequence(:sid) { |n| 1000000 + n }

    factory :invalid_student do
      name nil
    end
  end

end
