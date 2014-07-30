require 'rails_helper'

feature 'user adds a craft to their character', %Q{
  As a Shadowrun 4E player
  I want to add craft to my character
  So that they can drive around
} do

  scenario 'user adds a craft' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    craft = FactoryGirl.build(:craft)

    character_craft = FactoryGirl.build(:character_craft, character: character, craft: craft)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Vehicles and drones', from: 'PickGear')
    end

    within("#crafts-input") do
      fill_in 'Name', with: craft.name
      fill_in 'Description', with: craft.description
      fill_in 'Handling', with: craft.handling
      fill_in 'Acceleration', with: craft.acceleration
      fill_in 'Pilot', with: craft.pilot
      fill_in 'Speed', with: craft.speed
      fill_in 'Body', with: craft.body
      fill_in 'Armor', with: craft.armor
      fill_in 'Sensor', with: craft.sensor
      click_on 'Submit'
    end

    expect(page).to have_content craft.description
    expect(page).to have_content craft.name
  end

  scenario 'user tries to add a craft without needed attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    craft = FactoryGirl.build(:craft)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Vehicles and drones', from: 'PickGear')
    end

    within("#crafts-input") do
      click_on 'Submit'
    end

    expect(page).to_not have_content craft.description
    expect(page).to_not have_content craft.name

    expect(page).to have_content 'Uh oh! Your craft could not be saved.'
  end
end
