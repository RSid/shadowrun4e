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
    character_skill = FactoryGirl.create(:character_skill,
      character: character, skill: skill)

    visit character_character_skills_path(character)

    click_on (character_skill.id.to_s)
    expect(page).to_not have_content skill.name
  end

  scenario 'user deletes a quality' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    quality = FactoryGirl.create(:quality)

    character_quality = FactoryGirl.create(:character_quality,
      character: character, quality: quality)

    visit character_character_qualities_path(character)

    click_on (character_quality.id.to_s)
    expect(page).to_not have_content quality.name
  end

  scenario 'user deletes a connection' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    connection = FactoryGirl.create(:connection, character: character)

    visit character_connections_path(character)

    click_on (connection.id.to_s)
    expect(page).to_not have_content connection.name
  end

  scenario 'user tries to delete a skill for a character they didn\'t create' do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    skill = FactoryGirl.create(:skill)
    character_skill = FactoryGirl.create(:character_skill,
      character: character, skill: skill)

    visit character_character_skills_path(character)

    click_on (character_skill.id.to_s)
    expect(page).to have_content skill.name

    expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end

  scenario 'user tries to delete a quality for a character they didn\'t create' do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    quality = FactoryGirl.create(:quality)
    character_quality = FactoryGirl.create(:character_quality,
        character: character, quality: quality)

    visit character_character_qualities_path(character)

    click_on (character_quality.id.to_s)
    expect(page).to have_content quality.name

    expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end

  scenario 'user tries to delete a connection for a character they didn\'t create' do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)
    connection = FactoryGirl.create(:connection, character: character)

    visit character_connections_path(character)

    click_on (connection.id.to_s)
    expect(page).to have_content connection.name

    expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end
end
