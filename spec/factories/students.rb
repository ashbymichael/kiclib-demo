FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    sequence(:contact) { |n| Faker::Internet.email + n.to_s }

    factory :invalid_student do
      name nil
    end
  end

end
