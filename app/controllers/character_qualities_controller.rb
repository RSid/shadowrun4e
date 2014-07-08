class CharacterQualitiesController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @character_qualities = @character.character_qualities

    @quality = Quality.new
    @character_quality = CharacterQuality.new
  end

  def create
    @character = Character.find(params[:character_id])
    quality = Quality.find_by(name: quality_params[:name])

    if quality == nil
      quality = Quality.create(quality_params["quality"])
    end

    @character_quality = @character.character_qualities.build(character_quality_params.merge(quality: quality))

    if @character_quality.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your quality could not be saved.'
      @character = Character.find(params[:character_id])
      @skill = Skill.new
      @character_skill = CharacterSkill.new
      @quality = Quality.new
      @character_quality = CharacterQuality.new
      @connection = Connection.new
      render "/characters/show"
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @character_quality = CharacterQuality.find(params[:id])
    if current_user == @character.user
      if @character_quality.destroy
        flash[:notice] = 'Quality deleted!'
        redirect_to character_path(@character)
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
      @character = Character.find(params[:character_id])
      @skill = Skill.new
      @character_skill = CharacterSkill.new
      @quality = Quality.new
      @character_quality = CharacterQuality.new
      @connection = Connection.new
      render "/characters/show"
    end
  end

  private

  def character_quality_params
    params.require(:character_quality).permit(:character_id, :affect_rating)
  end

  def quality_params
    params.require(:character_quality).permit(:quality => [:name, :description])
  end
end
