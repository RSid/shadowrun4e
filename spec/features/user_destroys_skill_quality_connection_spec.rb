require 'rails_helper'

feature 'user deletes a skill, quality, or connection', %Q(
  As a Shadowrun 4E player
  I want to be able to delete my character's attributes
  to reflect their changes over time
) do

  scenario 'user deletes a skill' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    skill = FactoryGirl.create(:skill)
    character_skill = FactoryGirl.create(:character_skill, character: character, skill: skill)

    visit character_path(character)
    save_and_open_page
    within("#" + character_skill.id.to_s) do
      click_on ".fa fa-trash-o"
    end

    expect(page).to_not have_content skill.name
  end
end
