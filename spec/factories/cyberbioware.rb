FactoryGirl.define do
  factory :cyberbioware do
    sequence(:name) { |n| "Chainsaw arm #{n}" }
    description "Arm that's a chainsaw!"
    capacity "1"
    legality "F"
  end
end
