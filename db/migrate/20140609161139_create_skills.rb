class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |table|
      table.string :name, null: false
      table.string :default_skill
      table.string :skill_group
    end
  end
end
