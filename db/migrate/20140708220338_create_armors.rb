class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |table|
      table.string :name, null: false
      table.string :description
      table.string :ballistic
      table.string :impact
      table.string :legality
    end
  end
end
