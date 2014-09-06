require 'rails_helper'

feature 'admin sees all characters', %Q(
  As an administrator, I want to be able to see a list
  of all characters and the number of characters
  for the whole app
) do

  scenario 'admin user sees all characters' do
    admin = FactoryGirl.create(:user, :admin)
    sign_in_as(admin)

    metatype = FactoryGirl.create(:metatype)
    character = FactoryGirl.create(:character, metatype: metatype, user: admin)

    visit admin_characters_path

    expect(page).to have_content character.name
  end
end
