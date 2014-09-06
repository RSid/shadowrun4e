class Admin::InventoryController < ApplicationController
  def index
    @admin_tools = Inventory.tools
    @admin_weapons = Inventory.weapons
    @admin_armors = Inventory.armors
    @admin_crafts = Inventory.crafts
    @admin_cyberbiowares = Inventory.cyberbiowares
  end
end
