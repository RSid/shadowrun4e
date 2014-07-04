class CreateQualities < ActiveRecord::Migration
  def change
    create_table :qualities do |table|
      table.string :name, null: false
      table.string :description
      table.string :affected_stat
    end
  end
end
