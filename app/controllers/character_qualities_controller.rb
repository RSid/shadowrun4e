class CharacterQualitiesController < ApplicationController
  include EmptyFormObjects

  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character = Character.find(params[:character_id])
    @character_qualities = @character.character_qualities

    @quality = Quality.new
    @character_quality = CharacterQuality.new
  end

  def create
    @character = Character.find(params[:character_id])

    quality = Quality.find_or_create_by(quality_params["quality"])

    @character_quality = @character.character_qualities.build(character_quality_params.merge(quality: quality))

    respond_to do |format|
      format.html do
        if @character_quality.save
          redirect_to character_character_qualities_path(@character)
        else
          flash.now[:notice] = 'Uh oh! Your quality could not be saved.'
          generate_empty_form_objects
          render "/character_qualities/index"
        end
      end

      format.json do
        if @character_quality.save
          render json: {characterquality: @character_quality, quality: @character_quality.quality}
        else
          render json: { errors: @character.errors }
        end
      end
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    # @character_quality = CharacterQuality.find(params[:id])

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

    # if current_user == @character.user
    #   respond_to do |format|
    #     format.html do
    #       if @character_quality.destroy
    #         flash[:notice] = 'Quality deleted!'
    #         redirect_to character_character_qualities_path(@character)
    #       end
    #     end
    #
    #     format.json do
    #       if @character_quality.destroy
    #         render json: @character_quality
    #       end
    #     end
    #   end
    #
    # else
    #   flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
    #   generate_empty_form_objects
    #   render "/character_qualities/index"
    # end
  end

  private

  def character_quality_params
    params.require(:character_quality).permit(:character_id, :affect_rating)
  end

  def quality_params
    params.require(:character_quality).permit(:quality => [:name, :description])
  end
end
