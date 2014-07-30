class CharacterCyberbiowaresController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @inventory = InventoryFacade.new(@character)

    cyberbioware = Cyberbioware.find_or_create_by(cyberbioware_params["cyberbioware"])

    @character_cyberbioware = @character.character_cyberbioware.build(character_cyberbioware_params.merge(cyberbioware: cyberbioware))

    respond_to_create('cyberbioware',@character_cyberbioware, @character)
  end

  def destroy
    respond_to_destroy('cyberbioware', params[:id], @character)
  end

  private

  def character_cyberbioware_params
    params.require(:character_cyberbioware).permit(:character_id, :rating, :essence_cost)
  end

  def cyberbioware_params
    params.require(:character_cyberbioware).permit(:cyberbioware => [:name,
      :description, :capacity, :legality])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
