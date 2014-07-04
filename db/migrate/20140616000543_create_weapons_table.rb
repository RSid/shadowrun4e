class CreateWeaponsTable < ActiveRecord::Migration
  def change
    create_table :weapons do |table|
      table.string :name, null: false
      table.text :description
      table.string :damage, null: false
      table.string :damage_type, null: false
      table.boolean :melee, null: false
      table.string :concealability
      table.string :armor_piercing
      table.string :mode
      table.string :recoil
      table.string :ammo
      table.string :legality

    end
  end
end
