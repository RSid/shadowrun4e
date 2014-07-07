class CharacterQualitiesController < ApplicationController

  def new
    @character_quality = CharacterQuality.new
    @quality = Quality.new
  end

  def create
    @character = Character.find(params[:character_id])
    quality = Quality.find_by(name: quality_params[:name])

    if quality == nil
      quality = Quality.create(quality_params["quality"])
    end

    @character_quality = @character.character_qualities.build(character_quality_params.merge(quality: quality))
    binding.pry
    if @character_quality.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your skill could not be saved.'
      render :show
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
