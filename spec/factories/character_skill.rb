FactoryGirl.define do
  factory :character_skill do
    skill
    character
    rating '4'
    specialization 'No'
  end
end
