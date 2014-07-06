FactoryGirl.define do
  factory :character do
    sequence(:name) { |n| "Jack#{n}" }
    metatype
    body '4'
    agility '4'
    reaction '4'
    strength '4'
    charisma '4'
    intuition '4'
    logic '4'
    willpower '4'
    edge '4'
    essence '4'
    magic '0'
    initiative_passes '1'
    nuyen '5000'
    bio 'Some dude'
  end
end
