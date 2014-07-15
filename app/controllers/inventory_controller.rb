class InventoryController < ApplicationController
  include EmptyFormObjects

  def index
    @character_inventory = Inventory.new(Character.find(params[:character_id]))

    generate_empty_form_objects
  end
end
