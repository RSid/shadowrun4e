class CharacterToolsController < ApplicationController
  include EmptyFormObjects
  before_action :set_character

  def create
    @inventory = InventoryFacade.new(@character)

    tool = Tool.find_or_create_by(tool_params["tool"])

    @character_tool = @character.character_tools.build(character_tool_params.merge(tool: tool))
    respond_to do |format|
      format.html do
        if @character_tool.save
          redirect_to character_inventory_index_path(@character)
        else
          flash.now[:notice] = 'Uh oh! Your tool could not be saved.'
          @character = Character.find(params[:character_id])
          generate_empty_form_objects
          render "/inventory/index"
        end
      end

      format.json do
        if @character_tool.save
          render json: {charactertool: @character_tool, tool: @character_tool.tool}
        else
          render json: { errors: @character.errors }
        end
      end
    end
  end

  def destroy
    @character_tool = CharacterTool.find(params[:id])
    if current_user == @character.user
      respond_to do |format|
        format.html do
          if @character_tool.destroy
            flash[:notice] = 'Gear deleted!'
            redirect_to character_inventory_index_path(@character)
          end
        end

        format.json do
          if @character_tool.destroy
            render json: @character_tool
          end
        end
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
      redirect_to character_inventory_index_path(@character)
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
