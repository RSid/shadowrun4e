FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'qwerty1234567'

    trait :admin do
      admin true
    end
  end
end
