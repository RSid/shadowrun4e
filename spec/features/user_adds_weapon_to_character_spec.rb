# require 'rails_helper'
#
# feature 'user creates a character', %Q{
#   As a Shadowrun 4E player
#   I want to add weapons to my character's arsenal
#   So that my character can get better gear
# } do
#
#   scenario 'user adds a weapon' do
#     user = FactoryGirl.create(:user)
#     sign_in_as(user)
#
#     metatype = FactoryGirl.create(:metatype)
#     character = FactoryGirl.build(:character, metatype: metatype, user: user)
#     weapon =
#     visit character_path(character)
#
#     select('Weapons', from: 'PickGear')
# 
#   end
# end
