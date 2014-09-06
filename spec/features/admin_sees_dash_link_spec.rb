require 'rails_helper'

feature 'admin sees admin dashboard', %Q(
  As an administrator, I want to be the only
  one to see the dashboard with information
  for the whole app
) do

  scenario 'admin user sees dashboard link' do
    admin = FactoryGirl.create(:user, :admin)
    sign_in_as(admin)

    visit characters_path

    expect(page).to have_content 'Admin Dash'
  end

  scenario 'non-admin user does not see dashboard link' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit characters_path

    expect(page).to_not have_content 'Admin Dash'
  end
end
