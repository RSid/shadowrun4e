class InventoryController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @tool = Tool.new
    @character_tool = CharacterTool.new
    binding.pry
    @character_tools = @character.character_tools
  end
end
