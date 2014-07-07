FactoryGirl.define do
  factory :quality do
    sequence(:name) { |n| "Wonkiness style#{n}" }
    description 'So very.'
  end
end
