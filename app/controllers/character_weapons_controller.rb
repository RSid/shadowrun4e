class CharacterWeaponsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    weapon = Weapon.find_or_create_by(weapon_params["weapon"])

    @character_weapon = @character.character_weapons.build(character_weapon_params.merge(weapon: weapon))
    binding.pry
    respond_to_create('weapon',@character_weapon, @character)
  end

  def destroy
    respond_to_destroy('weapon', params[:id], @character)
  end

  private

  def character_weapon_params
    params.require(:character_weapon).permit(:character_id, :rating)
  end

  def weapon_params
    params.require(:character_weapon).permit(:weapon => [:name,
      :description, :damage, :damage_type, :armor_piercing,
      :concealability, :mode, :recoil, :ammo, :legality, :melee])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
