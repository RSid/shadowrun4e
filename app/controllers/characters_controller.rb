class CharactersController < ApplicationController
  def index
    if user_signed_in?
      @users_characters = current_user.characters
    end
  end

  def show
    @character = Character.find(params[:id])
    @attributes = @character.mutable_attributes
    @roller = DiceRoller.new
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

  def update
    @character = Character.find(params[:id])
    attributes_changing = params['character'].keys
    attributes_params = {}

    attributes_changing.each do |attribute|
      if @character.mutable_attributes.include?(attribute)
        attributes_params.merge!(attribute => params['character'][attribute][" type="])
      end
    end

    @character = Character.find(params[:id])
    if @character.update(attributes_params)
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your update could not be saved.'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    if current_user == @character.user
      if @character.destroy
        flash[:notice] = 'Character deleted!'
        redirect_to characters_path
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
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

  def character_params
    params.require(:character).permit(:name, :metatype_id, :body, :agility,
      :reaction, :strength, :charisma, :intuition, :logic, :willpower, :edge,
      :essence, :magic, :initiative_passes, :nuyen, :bio)
  end
end
