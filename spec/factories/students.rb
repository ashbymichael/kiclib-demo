FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    sequence(:contact) { |n| Faker::Internet.email + n.to_s }
    sequence(:sid) { |n| 1000000 + n }

    factory :invalid_student do
      name nil
    end
  end

end
