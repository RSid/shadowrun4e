class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |table|
      table.string :name, null: false
      table.string :description
    end
  end
end
