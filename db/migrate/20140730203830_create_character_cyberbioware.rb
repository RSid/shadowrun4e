class CreateCharacterCyberbioware < ActiveRecord::Migration
  def change
    create_table :character_cyberbiowares do |t|
      t.integer :character_id, null: false
      t.integer :cyberbioware_id, null: false
      t.integer :rating
      t.float :essence_cost, null: false
    end
  end
end
