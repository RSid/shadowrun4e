require 'rails_helper'

feature 'user deletes a inventory objects', %Q(
  As a Shadowrun 4E player
  I want to be able to delete my character's gear
  to reflect things they've used up or lost
) do

  scenario 'user deletes a tool', :js => true do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    tool = FactoryGirl.create(:tool)

    character_tool = FactoryGirl.create(:character_tool, character: character,
      tool: tool)

    visit character_inventory_index_path(character)

    click_on (character_tool.id.to_s)
    expect(page).to_not have_content tool.name
  end

  scenario 'user tries to delete a tool for a character they didn\'t create', :js => true do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    tool = FactoryGirl.create(:tool)

    character_tool = FactoryGirl.create(:character_tool, character: character, tool: tool)

    visit character_inventory_index_path(character)

    click_on (character_tool.id.to_s)
    expect(page).to have_content tool.name

    # expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end

  scenario 'user deletes a weapon', :js => true do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    weapon = FactoryGirl.create(:weapon)

    character_weapon = FactoryGirl.create(:character_weapon,
      character: character, weapon: weapon)

    visit character_inventory_index_path(character)

    click_on (character_weapon.id.to_s)
    expect(page).to_not have_content weapon.name
  end

  scenario 'user tries to delete a weapon for a character they didn\'t create', :js => true do
    user = FactoryGirl.create(:user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    weapon = FactoryGirl.create(:weapon)

    character_weapon = FactoryGirl.create(:character_weapon,
      character: character, weapon: weapon)

    visit character_inventory_index_path(character)

    click_on (character_weapon.id.to_s)
    expect(page).to have_content weapon.name

    # expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end

  scenario 'user deletes an armor', :js => true do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    armor = FactoryGirl.create(:armor)

    character_armor = FactoryGirl.create(:character_armor, character: character,
      armor: armor)

    visit character_inventory_index_path(character)

    click_on (character_armor.id.to_s)
    expect(page).to_not have_content armor.name
  end

  scenario 'user tries to delete an armor for a character they didn\'t create', :js => true do
    user = FactoryGirl.create(:user)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    armor = FactoryGirl.create(:armor)

    character_armor = FactoryGirl.create(:character_armor, character: character,
      armor: armor)

    visit character_inventory_index_path(character)

    click_on (character_armor.id.to_s)
    expect(page).to have_content armor.name

    # expect(page).to have_content 'You are not logged in. You must be logged in to edit a character.'
  end
end
