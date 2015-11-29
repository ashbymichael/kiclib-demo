FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    contact { Faker::Internet.email }
  end

end
