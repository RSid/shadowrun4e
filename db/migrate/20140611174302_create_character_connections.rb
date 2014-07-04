class CreateCharacterConnections < ActiveRecord::Migration
  def change
    create_table :connections do |table|
      table.string :name, null: false
      table.string :description
      table.integer :loyalty, null: false
      table.integer :connection, null: false
      table.integer :character_id, null: false
    end
  end
end
