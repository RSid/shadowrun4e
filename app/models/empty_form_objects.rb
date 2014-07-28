module EmptyFormObjects
  def generate_empty_form_objects
    if params[:character_id]
      @character = Character.find(params[:character_id])
    else
      @character = Character.find(params[:id])
    end

    @character_inventory = Inventory.new(@character)

    @attributes = @character.mutable_attributes

    @skill = Skill.new
    @character_skill = CharacterSkill.new

    @quality = Quality.new
    @character_quality = CharacterQuality.new

    @connection = Connection.new

    @tool = Tool.new
    @character_tool = CharacterTool.new

    @weapon = Weapon.new
    @character_weapon = CharacterWeapon.new

    @armor = Armor.new
    @character_armor = CharacterArmor.new

    @craft = Craft.new
    @character_craft = CharacterCraft.new
  end
end
