FactoryGirl.define do
  factory :transaction do
    association :student
    association :book
    due Time.now + 2.weeks
    status "out"
  end

end
