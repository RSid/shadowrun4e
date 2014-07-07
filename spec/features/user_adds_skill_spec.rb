require 'rails_helper'

feature 'user creates a character', %Q{
  As a Shadowrun 4E player
  I want to add skills to my character
  So that they can improve
} do

  scenario 'user adds a skill' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.build(:character, metatype: metatype, user: user)

    skill = FactoryGirl.create(:skill)

    character_skill = FactoryGirl.create(:character_skill,
      character: character, user: user)

    visit character_path(character)

    within("#add-skill") do
      fill_in 'Name', with: skill.name
      fill_in 'Rating', with: character_skill.rating
      fill_in 'Specialization', with: character_skill.specialization
      fill_in 'Skill group', with: skill.skill_group
      fill_in 'Default', with: skill.default
      click_on 'Submit'
    end

    expect(page).to have_content skill.rating
    expect(page).to have_content skill.name
    expect(page).to have_content skill.specialization
    expect(page).to have_content skill.skill_group
    expect(page).to have_content skill.default
  end
end
