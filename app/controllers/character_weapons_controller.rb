class CharacterWeaponsController < ApplicationController
  include EmptyFormObjects

  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @character = Character.find(params[:character_id])

    weapon = Weapon.find_or_create_by(weapon_params["weapon"])

    @character_weapon = @character.character_weapons.build(character_weapon_params.merge(weapon: weapon))
    respond_to do |format|
      format.html do
        if @character_weapon.save
          redirect_to character_inventory_index_path(@character)
        else
          flash.now[:notice] = 'Uh oh! Your weapon could not be saved.'
          generate_empty_form_objects
          render "inventory/index"
        end
      end

      format.json do
        if @character_weapon.save
          render json: {characterweapon: @character_weapon, weapon: @character_weapon.weapon}
        else
          render json: { errors: @character.errors }
        end
      end
    end
  end

  def destroy
    @character = Character.find(params[:character_id])

    render_unauthorized unless @character.user == current_user

    @character_weapon = @character.character_weapons.destroy(params[:id])

    respond_to do |format|
      format.html do
        flash[:notice] = 'Weapon deleted!'
        redirect_to character_inventory_index_path(@character)
      end
      format.json do
        render json: @character_weapon
      end
    end
  end

  private

  def character_weapon_params
    params.require(:character_weapon).permit(:character_id, :affect_rating)
  end

  def weapon_params
    params.require(:character_weapon).permit(:weapon => [:name,
      :description, :damage, :damage_type, :rating, :armor_piercing,
      :concealability, :mode, :recoil, :ammo, :legality, :melee])
  end
end
