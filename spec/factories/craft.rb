FactoryGirl.define do
  factory :craft do
    sequence(:name) { |n| "Car #{n}" }
    description 'Vroom.'
    handling '+1'
    acceleration '12/20'
    pilot '1'
    speed '1'
    body '1'
    armor '1'
    sensor '1'
  end
end
