require 'rails_helper'

feature 'user adds a tool to their character', %Q{
  As a Shadowrun 4E player
  I want to add tools to my character
  So that they can have more gizmos
} do

  scenario 'user adds a tool' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    tool = FactoryGirl.build(:tool)

    character_tool = FactoryGirl.build(:character_tool, character: character, tool: tool)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('General', from: 'PickGear')
    end

    within("#general-gear-input") do
      fill_in 'Name', with: tool.name
      fill_in 'Description', with: tool.description
      click_on 'Submit'
    end

    expect(page).to have_content tool.description
    expect(page).to have_content tool.name
  end

  scenario 'user tries to add a tool without needed attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    tool = FactoryGirl.build(:tool)

    character_tool = FactoryGirl.build(:character_tool, character: character, tool: tool)

    visit character_inventory_index_path(character)

    within("#gear-type") do
      select('General', from: 'PickGear')
    end

    within("#general-gear-input") do
      click_on 'Submit'
    end

    expect(page).to_not have_content tool.description
    expect(page).to_not have_content tool.name

    expect(page).to have_content 'Uh oh! Your tool could not be saved.'
  end
end
