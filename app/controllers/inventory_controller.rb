class InventoryController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
  end
end
