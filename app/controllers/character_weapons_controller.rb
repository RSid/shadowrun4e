class CharacterWeaponsController < ApplicationController
  include EmptyFormObjects
  
  def create
    @character = Character.find(params[:character_id])

    weapon = Weapon.find_or_create_by(weapon_params["weapon"])

    @character_weapon = @character.character_weapons.build(character_weapon_params.merge(weapon: weapon))

    if @character_weapon.save
      redirect_to character_inventory_index_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your weapon could not be saved.'
      generate_empty_form_objects
      render "inventory/index"
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @character_weapon = CharacterWeapon.find(params[:id])
    if current_user == @character.user
      if @character_weapon.destroy
        flash[:notice] = 'Weapon deleted!'
        redirect_to character_inventory_index_path(@character)
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
      @character = Character.find(params[:character_id])
      redirect_to character_inventory_index_path(@character)
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
