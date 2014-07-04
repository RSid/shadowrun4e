class CreateCharacterWeaponsTable < ActiveRecord::Migration
  def change
    create_table :character_weapons do |table|
      table.integer :character_id, null: false
      table.integer :weapon_id, null: false
      table.integer :rating

    end
  end
end
