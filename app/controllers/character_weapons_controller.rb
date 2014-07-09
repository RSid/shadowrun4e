class CharacterWeaponsController < ApplicationController
  def create
    binding.pry
    @character = Character.find(params[:character_id])
    weapon = Weapon.find_by(name: weapon_params[:name])

    if weapon == nil
      weapon = Weapon.create(weapon_params["weapon"])
    end

    @character_weapon = @character.character_weapons.build(character_weapon_params.merge(weapon: weapon))

    if @character_weapon.save
      redirect_to character_inventory_index_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your quality could not be saved.'
      @character = Character.find(params[:character_id])
      render "inventory/index"
    end
  end

  # def destroy
  #   @character = Character.find(params[:character_id])
  #   @character_quality = CharacterQuality.find(params[:id])
  #   if current_user == @character.user
  #     if @character_quality.destroy
  #       flash[:notice] = 'Quality deleted!'
  #       redirect_to character_character_qualities_path(@character)
  #     end
  #   else
  #     flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
  #     @character = Character.find(params[:character_id])
  #     render "inventory/index"
  #   end
  # end

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
