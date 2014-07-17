class CharacterQualitiesController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character_qualities = @character.character_qualities

    @quality = Quality.new
    @character_quality = CharacterQuality.new
  end

  def create
    quality = Quality.find_or_create_by(quality_params["quality"])

    @character_quality = @character.character_qualities.build(character_quality_params.merge(quality: quality))

    respond_to_create('quality',@character_quality, @character)
  end

  def destroy
    render_unauthorized unless @character.user == current_user

    @character_quality = @character.character_qualities.destroy(params[:id])

      respond_to do |format|
        format.html do
          flash[:notice] = 'Skill deleted!'
          redirect_to character_character_qualities_path(@character)
        end
        format.json do
          render json: @character_quality
        end
      end
  end

  private

  def character_quality_params
    params.require(:character_quality).permit(:character_id, :affect_rating)
  end

  def quality_params
    params.require(:character_quality).permit(:quality => [:name, :description])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
