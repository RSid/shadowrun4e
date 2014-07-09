require 'rails_helper'

feature 'user creates a character', %Q{
  As a Shadowrun 4E player
  I want to add weapons to my character's arsenal
  So that my character can get better gear
} do

  scenario 'user adds a weapon' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    weapon = FactoryGirl.build(:weapon)

    character_weapon = FactoryGirl.build(:character_weapon, character: character,
      weapon: weapon)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Weapon', from: 'PickGear')
    end

    within("#weapons-input") do
      fill_in 'Rating', with: character_weapon.rating
      fill_in 'Name', with: weapon.name
      fill_in 'Description', with: weapon.description
      fill_in 'Damage', with: weapon.damage
      fill_in 'Damage type', with: weapon.damage_type
      fill_in 'Armor piercing', with: weapon.armor_piercing
      fill_in 'Concealability', with: weapon.concealability
      fill_in 'Mode', with: weapon.mode
      fill_in 'Recoil', with: weapon.recoil
      fill_in 'Ammo', with: weapon.ammo
      fill_in 'Legality', with: weapon.legality
      select('No', from: 'character_weapon_weapon_melee')
      click_on 'Submit'
    end

    expect(page).to have_content weapon.description
    expect(page).to have_content weapon.name
  end

  scenario 'user tries to add a weapon without required attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    weapon = FactoryGirl.build(:weapon)

    character_weapon = FactoryGirl.build(:character_weapon, character: character,
      weapon: weapon)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Weapon', from: 'PickGear')
    end

    within("#weapons-input") do
      click_on 'Submit'
    end

    expect(page).to_not have_content weapon.description
    expect(page).to_not have_content weapon.name

    expect(page).to have_content 'Uh oh! Your weapon could not be saved.'
  end
end
