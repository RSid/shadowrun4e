class CreateCharacterSkills < ActiveRecord::Migration
  def change
    create_table :character_skills do |table|
      table.integer :character_id, null: false
      table.integer :skill_id, null: false
      table.string :specialization
      table.integer :rating, null: false
    end
  end
end
