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

  def character_cyberbiowares
    @character.character_cyberbiowares
  end

  def self.tools
    sql = "SELECT tools.name, tools.description,
    COUNT(character_tools.tool_id)
    FROM tools
    LEFT JOIN character_tools
    ON tools.id = character_tools.tool_id
    GROUP BY tools.name,tools.description"
    @admin_tools = ActiveRecord::Base.connection.execute(sql).to_a.sort_by{|tool| tool["count"]}.reverse!
  end
end
