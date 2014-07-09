FactoryGirl.define do
  factory :tool do
    sequence(:name) { |n| "#{n} foot pole" }
    description 'Pretty useless.'
  end
end
