class CharacterToolsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @inventory = InventoryFacade.new(@character)

    tool = Tool.find_or_create_by(tool_params["tool"])

    @character_tool = @character.character_tools.build(character_tool_params.merge(tool: tool))

    respond_to_create('tool',@character_tool, @character)
  end

  def destroy
    respond_to_destroy('tool', params[:id], @character)
  end

  private

  def character_tool_params
    params.require(:character_tool).permit(:character_id)
  end

  def tool_params
    params.require(:character_tool).permit(:tool => [:name, :description])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
