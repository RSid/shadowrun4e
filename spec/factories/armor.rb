FactoryGirl.define do
  factory :armor do
    sequence(:name) { |n| "Jacket #{n}" }
    description 'You wear it.'
    ballistic '1'
    impact '1'
  end
end
