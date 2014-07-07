FactoryGirl.define do
  factory :skill do
    sequence(:name) { |n| "Punch style#{n}" }
    skill_group 'Firearms'
    default_skill 'Agility'
  end
end
