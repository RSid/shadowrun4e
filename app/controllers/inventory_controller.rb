class InventoryController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    binding.pry
    @tool = Tool.new
    @character_tool = CharacterTool.new
  end
end
