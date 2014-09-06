class Admin::InventoryController < ApplicationController
  def index
    @admin_tools = Inventory.tools
    @admin_weapons = Inventory.weapons
    @admin_armors = Inventory.armors
  end
end
