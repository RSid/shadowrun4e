class CharacterCraftsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @inventory = InventoryFacade.new(@character)

    craft = Craft.find_or_create_by(craft_params["craft"])

    @character_craft = @character.character_crafts.build(character_craft_params.merge(craft: craft))

    respond_to_create('craft',@character_craft, @character)
  end

  def destroy
    respond_to_destroy('craft', params[:id], @character)
  end

  private

  def character_craft_params
    params.require(:character_craft).permit(:character_id)
  end

  def craft_params
    params.require(:character_craft).permit(:craft => [:name, :description,
      :handling, :acceleration, :pilot, :speed, :body, :armor, :sensor])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
