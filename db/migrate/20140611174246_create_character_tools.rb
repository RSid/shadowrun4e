class CreateCharacterTools < ActiveRecord::Migration
  def change
    create_table :character_tools do |table|
      table.integer :character_id, null: false
      table.integer :tool_id, null: false
    end
  end
end
