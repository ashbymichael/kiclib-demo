FactoryGirl.define do
  factory :user do
    password "password"
    sequence(:username) { |n| "testuser#{n}" }
  end

end
