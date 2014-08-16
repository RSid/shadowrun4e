class Admin::InventoryController < ApplicationController
  def index
    @admin_tools = Inventory.tools
  end
end
