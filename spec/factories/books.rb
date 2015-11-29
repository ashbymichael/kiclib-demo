FactoryGirl.define do
  factory :book do
    title { Faker::Lorem.sentence }
  end

end
