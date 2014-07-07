require 'rails_helper'

feature 'user creates a character', %Q{
  As a Shadowrun 4E player
  I want to add myself as a user
  So that my character information is saved
} do

  scenario 'user creates a character' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.build(:character, metatype: metatype, user: user)

    visit new_character_path

    fill_in 'Name', with: character.name
    select(character.metatype.name, from: 'character_metatype_id')
    fill_in 'Body', with: character.body
    fill_in 'Agility', with: character.agility
    fill_in 'Reaction', with: character.reaction
    fill_in 'Strength', with: character.strength
    fill_in 'Charisma', with: character.charisma
    fill_in 'Intuition', with: character.intuition
    fill_in 'Logic', with: character.logic
    fill_in 'Willpower', with: character.willpower
    fill_in 'Edge', with: character.edge
    fill_in 'Essence', with: character.essence
    fill_in 'Magic', with: character.magic
    fill_in 'Initiative passes', with: character.initiative_passes
    fill_in 'Nuyen', with: character.nuyen
    fill_in 'Bio', with: character.bio
    click_on 'Create'

    expect(page).to have_content character.name
  end

  scenario 'user tries to create a character without needed attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.build(:character, metatype: metatype, user: user)

    visit new_character_path

    click_on 'Create'

    expect(page).to_not have_content character.name
    expect(page).to have_content 'Uh oh! Your character could not be saved.'
  end
end
