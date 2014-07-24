class CreateCharacterArmors < ActiveRecord::Migration
  def change
    create_table :character_armors do |table|
      table.integer :character_id, null: false
      table.integer :armor_id, null: false
    end
  end
end
