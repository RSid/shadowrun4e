class CharactersController < ApplicationController

  def index
    if user_signed_in?
      @users_characters = current_user.characters
    end
  end

  def show
    @character = Character.find(params[:id])
    @skill = Skill.new
    @character_skill = CharacterSkill.new
    @quality = Quality.new
    @character_quality = CharacterQuality.new
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.characters.build(character_params)

    if @character.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your character could not be saved.'
      render :new
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :metatype_id, :body, :agility,
      :reaction, :strength, :charisma, :intuition, :logic, :willpower, :edge,
      :essence, :magic, :initiative_passes, :nuyen, :bio)
  end
end
