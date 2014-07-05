class CharactersController < ApplicationController

  def index
    if user_signed_in?
      @users_characters = current_user.characters
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.character.build(character_params)
  end

  private

  def character_params
    #will want to change metatype form to dropdown
    #take cars systems check as model
    params.require(:character).permit(:name, :metatype_id, :body, :agilty,
      :reaction, :strength, :charisma, :intuition, :logic, :willpower, :edge,
      :essence, :magic, :initiative_passes, :nuyen, :bio)
  end
end
