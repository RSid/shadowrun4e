class ConnectionsController < ApplicationController
  def create
    @character = Character.find(params[:character_id])

    @connection = @character.connections.build(connection_params)

    if @connection.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your skill could not be saved.'
      @character = Character.find(params[:id])
      @skill = Skill.new
      @character_skill = CharacterSkill.new
      @quality = Quality.new
      @character_quality = CharacterQuality.new
      @connection = Connection.new
      render :show
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @connection = Connection.find(params[:id])
    if current_user == @character.user
      if @connection.destroy
        flash[:notice] = 'Skill deleted!'
        redirect_to character_path(@character)
      end
    else
      @character = Character.find(params[:id])
      @skill = Skill.new
      @character_skill = CharacterSkill.new
      @quality = Quality.new
      @character_quality = CharacterQuality.new
      @connection = Connection.new
      render :show
    end
  end

  private

  def connection_params
    params.require(:connection).permit(:name, :description, :loyalty, :connection)
  end
end
