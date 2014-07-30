class CreateCyberbioware < ActiveRecord::Migration
  def change
    create_table :cyberbiowares do |t|
      t.string :name, null: false
      t.string :capacity
      t.string :legality
    end
  end
end
