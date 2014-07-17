class CharacterToolsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  before_action :set_character

  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def create
    @inventory = InventoryFacade.new(@character)

    tool = Tool.find_or_create_by(tool_params["tool"])

    @character_tool = @character.character_tools.build(character_tool_params.merge(tool: tool))

    respond_to_create('tool',@character_tool, @character)
  end

  def destroy
    @character = Character.find(params[:character_id])

    render_unauthorized unless @character.user == current_user

    @character_tool = @character.character_tools.destroy(params[:id])

      respond_to do |format|
        format.html do
          flash[:notice] = 'Gear deleted!'
            redirect_to character_inventory_index_path(@character)
          end

        format.json do
          render json: @character_tool
        end
      end
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
