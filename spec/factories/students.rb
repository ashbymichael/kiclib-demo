FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    sequence(:contact) { |n| Faker::Internet.email + n.to_s }
  end

end
