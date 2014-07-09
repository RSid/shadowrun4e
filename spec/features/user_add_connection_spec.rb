require 'rails_helper'

feature 'user adds a connection to their character', %Q{
  As a Shadowrun 4E player
  I want to add connection to my character
  So that they can know a guy who knows a guy
} do

  scenario 'user adds a connection' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    connection = FactoryGirl.create(:connection, character: character)

    visit character_connections_path(character)

    within("#add-connection") do
      fill_in 'Name', with: connection.name
      fill_in 'Description', with: connection.description
      fill_in 'Loyalty', with: connection.loyalty
      fill_in 'Connection', with: connection.connection

      click_on 'Submit'
    end

    expect(page).to have_content connection.name
    expect(page).to have_content connection.description
    expect(page).to have_content connection.loyalty
    expect(page).to have_content connection.connection
  end

  scenario 'user tries to add a connection missing attributes' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: user)

    connection = FactoryGirl.build(:connection, character: character)

    visit character_connections_path(character)

    within("#add-connection") do

      click_on 'Submit'
    end

    expect(page).to_not have_content connection.name

    expect(page).to have_content 'Uh oh! Your connection could not be saved.'
  end
end
