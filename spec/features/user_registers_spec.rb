require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

feature 'user creates a new user', %Q{
  As a Shadowrun 4E player
  I want to add myself as a user
  So that my characters are saved
} do

  scenario 'user creates a profile' do

    user = FactoryGirl.build(:user)

    visit new_user_registration_path

    fill_in 'Email', with: user.email
    within('.control-group.password.required.user_password') do
      fill_in 'Password', with: user.password
    end
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(User.count).to eq(1)
    expect(page).to have_content 'successfully'
  end

  scenario 'without required attributes' do

    visit new_user_registration_path
    click_on 'Sign up'

    expect(page).to_not have_content 'successfully'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add a user with an email that already exists' do

    user = FactoryGirl.build(:user)

    visit new_user_registration_path
    fill_in 'Email', with: user.email
    within('.control-group.password.required.user_password') do
      fill_in 'Password', with: user.password
    end
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    click_on 'Logout'

    visit new_user_registration_path
    fill_in 'Email', with: user.email
    within('.control-group.password.required.user_password') do
      fill_in 'Password', with: user.password
    end
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end
