class InventoryController < ApplicationController
  def index
    @character = Character.find(params[:character_id])

    @tool = Tool.new
    @character_tool = CharacterTool.new
    @character_tools = @character.character_tools

    @weapon = Weapon.new
    @character_weapon = CharacterWeapon.new
    @character_weapons = @character.character_weapons
  end
end
