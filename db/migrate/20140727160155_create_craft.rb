class CreateCraft < ActiveRecord::Migration
  def change
    create_table :crafts do |t|
      t.string :name, null: false
      t.string :description
      t.string :handling
      t.string :acceleration
      t.integer :pilot
      t.integer :speed
      t.integer :body
      t.integer :armor
      t.integer :sensor
    end
  end
end
