require 'rails_helper'

feature 'user deletes a inventory objects', %Q(
  As a Shadowrun 4E player
  I want to be able to delete my character's gear
  to reflect things they've used up or lost
) do

  scenario 'user deletes a tool' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    tool = FactoryGirl.build(:tool)

    character_tool = FactoryGirl.build(:character_tool, character: character, tool: tool)

    visit character_inventory_index_path(character)

    click_on (character_tool.id.to_s)
    expect(page).to_not have_content tool.name
  end
end
