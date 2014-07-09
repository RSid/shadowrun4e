FactoryGirl.define do
  factory :weapon do
    sequence(:name) { |n| "Gun #{n}" }
    description 'Powpow.'
    damage '5'
    damage_type 'p'
    armor_piercing '1'
    concealability '1'
    mode 'SA'
    recoil '2'
    ammo 'flechette'
    legality 'f'
    melee 'No'
  end
end
