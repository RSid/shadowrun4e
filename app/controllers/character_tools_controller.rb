class CharacterToolsController < ApplicationController
  def index
  end

  def create
    @character = Character.find(params[:character_id])
    tool = Tool.find_by(name: tool_params[:name])

    if tool == nil
      tool = Tool.create(tool_params["tool"])
    end

    @character_tool = @character.character_tools.build(character_tool_params.merge(tool: tool))

    if @character_tool.save
      redirect_to character_inventory_index_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your tool could not be saved.'
      @character = Character.find(params[:character_id])
      @tool = Tool.new
      @character_tool = CharacterTool.new
      render "inventory/index"
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @character_tool = CharacterTool.find(params[:id])
    if current_user == @character.user
      if @character_tool.destroy
        flash[:notice] = 'Gear deleted!'
        redirect_to character_inventory_index_path(@character)
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
      render "/characters/show/inventory"
    end
  end

  private

  def character_tool_params
    params.require(:character_tool).permit(:character_id)
  end

  def tool_params
    params.require(:character_tool).permit(:tool => [:name, :description])
  end
end
