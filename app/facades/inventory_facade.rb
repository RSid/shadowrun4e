class InventoryFacade
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def new_tool
    @new_tool = Tool.new
  end

  def character_tools
    @character_tools = character.character_tools
  end

  def tools
    @tools = character.character_tools.tools
  end
end
