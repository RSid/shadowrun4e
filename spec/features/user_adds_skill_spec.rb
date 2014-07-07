require 'rails_helper'

feature 'user adds a skill to their character', %Q{
  As a Shadowrun 4E player
  I want to add skills to my character
  So that they can improve
} do

  scenario 'user adds a skill' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    skill = FactoryGirl.create(:skill)

    character_skill = FactoryGirl.create(:character_skill, character: character, skill: skill)

    visit character_path(character)

    within("#add-skill") do
      fill_in 'Name', with: skill.name
      fill_in 'Rating', with: character_skill.rating
      fill_in 'Specialization', with: character_skill.specialization
      fill_in 'Skill group', with: skill.skill_group
      fill_in 'Default', with: skill.default_skill
      click_on 'Submit'
    end

    expect(page).to have_content character_skill.rating
    expect(page).to have_content skill.name
    expect(page).to have_content character_skill.specialization
  end
end
