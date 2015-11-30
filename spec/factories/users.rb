FactoryGirl.define do

  factory :user do
    password "password"
    sequence(:username) { |n| "testuser#{n}" }

    factory :invalid_user do
      username nil
    end
  end

end
