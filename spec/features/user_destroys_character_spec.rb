require 'rails_helper'

feature 'user deletes a character', %Q(
  As a Shadowrun 4E player
  I want to delete a character
  because they're no longer in play
) do

  scenario 'user deletes a character' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    visit character_path(character)

    within("#character-deletion") do
      click_on 'Delete this character? This action cannot be undone.'
    end

    expect(page).to_not have_content character.name
  end

  scenario 'user tries to delete a character they didn\'t create' do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    visit character_path(character)

    within("#character-deletion") do
      click_on 'Delete this character? This action cannot be undone.'
    end

    expect(page).to have_content character.name
  end
end