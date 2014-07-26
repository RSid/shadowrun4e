require 'rails_helper'

feature 'user adds a tool to their character', %Q(
  As a Shadowrun 4E player
  I want to add armor to my character
  So that they can be better protected
) do

  scenario 'user adds an armor' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    armor = FactoryGirl.build(:armor)

    character_armor = FactoryGirl.build(:character_armor, character: character,
      armor: armor)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Armor', from: 'PickGear')
    end

    within("#armor-input") do
      fill_in 'Name', with: armor.name
      fill_in 'Description', with: armor.description
      fill_in 'Ballistic', with: armor.ballistic
      fill_in 'Impact', with: armor.impact
      click_on 'Submit'
    end

    expect(page).to have_content armor.description
    expect(page).to have_content armor.name
    expect(page).to have_content armor.ballistic
    expect(page).to have_content armor.impact
  end

  scenario 'user tries to add an armor without needed attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    armor = FactoryGirl.build(:armor)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Armor', from: 'PickGear')
    end

    within("#armor-input") do
      click_on 'Submit'
    end

    expect(page).to_not have_content armor.description
    expect(page).to_not have_content armor.name

    expect(page).to have_content 'Uh oh! Your armor could not be saved.'
  end
end
