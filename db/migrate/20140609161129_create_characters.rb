class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |table|
      table.string :name, null: false
      table.integer :user_id, null: false
      table.integer :gm_id
      table.integer :metatype_id, null: false
      table.integer :body, null: false
      table.integer :agility, null: false
      table.integer :reaction, null: false
      table.integer :strength, null: false
      table.integer :charisma, null: false
      table.integer :intuition, null: false
      table.integer :logic, null: false
      table.integer :willpower, null: false
      table.integer :edge, null: false
      table.integer :nuyen, null: false
      table.float :essence, null: false
      table.integer :magic
      table.integer :initiative_passes, null: false
      table.text  :bio

    end
  end
end
