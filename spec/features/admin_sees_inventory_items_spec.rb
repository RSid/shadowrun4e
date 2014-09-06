require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

feature 'admin sees all inventory items', %Q(
  As an administrator, I want to be able to see a list
  of all inventor items for all characters
  and the number of characters using each
  for the whole app
) do

  user1 = FactoryGirl.create(:user)
  user2 = FactoryGirl.create(:user)

  metatype = FactoryGirl.create(:metatype)
  jack = FactoryGirl.create(:character, metatype: metatype, user: user1)
  jill = FactoryGirl.create(:character, metatype: metatype, user: user2)

  admin = FactoryGirl.create(:user, :admin)

  scenario 'admin user sees all tools' do

    tool1 = FactoryGirl.create(:tool)
    tool2 = FactoryGirl.create(:tool)

    charactertool1 = FactoryGirl.create(:character_tool, character: jack, tool: tool1)
    charactertool2 = FactoryGirl.create(:character_tool, character: jill, tool: tool2)

    sign_in_as(admin)

    visit admin_inventory_index_path

    expect(page).to have_content tool1.name
    expect(page).to have_content tool2.name
    expect(page).to have_content '2'
  end

  scenario 'admin user sees all weapons' do

    weapon1 = FactoryGirl.create(:weapon)
    weapon2 = FactoryGirl.create(:weapon)

    characterweapon1 = FactoryGirl.create(:character_weapon, character: jack, weapon: weapon1)
    characterweapon2 = FactoryGirl.create(:character_weapon, character: jill, weapon: weapon2)

    sign_in_as(admin)

    visit admin_inventory_index_path

    expect(page).to have_content weapon1.name
    expect(page).to have_content weapon2.name
    expect(page).to have_content '2'
  end

  scenario 'admin user sees all armor' do

    armor1 = FactoryGirl.create(:armor)
    armor2 = FactoryGirl.create(:armor)

    characterarmor1 = FactoryGirl.create(:character_armor, character: jack, armor: armor1)
    characterarmor2 = FactoryGirl.create(:character_armor, character: jill, armor: armor2)

    sign_in_as(admin)

    visit admin_inventory_index_path

    expect(page).to have_content armor1.name
    expect(page).to have_content armor2.name
    expect(page).to have_content '2'
  end

  scenario 'admin user sees all crafts' do

    craft1 = FactoryGirl.create(:craft)
    craft2 = FactoryGirl.create(:craft)

    charactercraft1 = FactoryGirl.create(:character_craft, character: jack, craft: craft1)
    charactercraft2 = FactoryGirl.create(:character_craft, character: jill, craft: craft2)

    sign_in_as(admin)

    visit admin_inventory_index_path

    expect(page).to have_content craft1.name
    expect(page).to have_content craft2.name
    expect(page).to have_content '2'
  end

  scenario 'admin user sees all cyber/bioware' do

    cyberbioware1 = FactoryGirl.create(:cyberbioware)
    cyberbioware2 = FactoryGirl.create(:cyberbioware)

    charactercyberbioware1 = FactoryGirl.create(:character_cyberbioware, character: jack, cyberbioware: cyberbioware1)
    charactercyberbioware2 = FactoryGirl.create(:character_cyberbioware, character: jill, cyberbioware: cyberbioware2)

    sign_in_as(admin)

    visit admin_inventory_index_path

    expect(page).to have_content cyberbioware1.name
    expect(page).to have_content cyberbioware2.name
    expect(page).to have_content '2'
  end
end
