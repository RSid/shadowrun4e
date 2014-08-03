require 'rails_helper'

feature 'user creates a character', %Q(
  As a Shadowrun 4E player
  I want to add cyberware or bioware to my character
  So that they can augment themselves
) do

  scenario 'user adds a cyberbioware' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    cyberbioware = FactoryGirl.build(:cyberbioware)

    character_cyberbioware = FactoryGirl.build(:character_cyberbioware, character: character,
      cyberbioware: cyberbioware)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Cyberware and Bioware', from: 'PickGear')
    end

    within("#cyberbioware-input") do
      fill_in 'Rating', with: character_cyberbioware.rating
      fill_in 'Essence cost', with: character_cyberbioware.essence_cost
      fill_in 'Name', with: cyberbioware.name
      fill_in 'Description', with: cyberbioware.description
      fill_in 'Capacity', with: cyberbioware.capacity
      fill_in 'Legality', with: cyberbioware.legality
      click_on 'Submit'
    end

    expect(page).to have_content cyberbioware.description
    expect(page).to have_content cyberbioware.name
  end

  scenario 'user tries to add a cyberbioware without required attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    cyberbioware = FactoryGirl.build(:cyberbioware)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('Cyberware and Bioware', from: 'PickGear')
    end

    within("#cyberbioware-input") do
      click_on 'Submit'
    end

    expect(page).to_not have_content cyberbioware.description
    expect(page).to_not have_content cyberbioware.name

    expect(page).to have_content 'Uh oh! Your cyberbioware could not be saved.'
  end
end
