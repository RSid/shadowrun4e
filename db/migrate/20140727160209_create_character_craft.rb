class CreateCharacterCraft < ActiveRecord::Migration
  def change
    create_table :character_crafts do |t|
      t.integer :character_id, null: false
      t.integer :craft_id, null: false
      t.string :mods
    end
  end
end
