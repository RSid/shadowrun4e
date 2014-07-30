class Inventory
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def character_tools
    @character.character_tools
  end

  def character_weapons
    @character.character_weapons
  end

  def character_armors
    @character.character_armors
  end

  def character_crafts
    @character.character_crafts
  end
end
