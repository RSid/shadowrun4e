FactoryGirl.define do
  factory :connection do
    sequence(:name) { |n| "Jane#{n}" }
    description 'Just your average.'
    loyalty '1'
    connection '1'
  end
end
