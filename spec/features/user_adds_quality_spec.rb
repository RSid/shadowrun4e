require 'rails_helper'

feature 'user adds a quality to their character', %Q{
  As a Shadowrun 4E player
  I want to add qualities to my character
  So that they can have nuances
} do

  scenario 'user adds a quality' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    quality = FactoryGirl.create(:quality)

    character_quality = FactoryGirl.create(:character_quality,
      character: character, quality: quality)

    visit character_path(character)

    within("#add-quality") do
      fill_in 'Name', with: quality.name
      fill_in 'Affect rating', with: character_quality.affect_rating
      fill_in 'Description', with: quality.description

      click_on 'Submit'
    end

    expect(page).to have_content character_quality.affect_rating
    expect(page).to have_content quality.name
    expect(page).to have_content quality.description
  end
end
