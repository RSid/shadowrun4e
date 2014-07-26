class CharacterArmorsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @inventory = InventoryFacade.new(@character)

    armor = Armor.find_or_create_by(armor_params["armor"])
    binding.pry
    @character_armor = @character.character_armors.build(character_armor_params.merge(armor: armor))

    respond_to_create('armor',@character_armor, @character)
  end

  def destroy
    respond_to_destroy('armor', params[:id], @character)
  end

  private

  def character_armor_params
    params.require(:character_armor).permit(:character_id)
  end

  def armor_params
    params.require(:character_armor).permit(:armor => [:name, :description,
      :ballistic, :impact, :legality])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
