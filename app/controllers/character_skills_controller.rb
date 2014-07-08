class CharacterSkillsController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @character_skills = @character.character_skills

    @skill = Skill.new
    @character_skill = CharacterSkill.new
  end

  def create
    @character = Character.find(params[:character_id])
    skill = Skill.find_by(name: skill_params[:name])

    if skill == nil
      skill = Skill.create(skill_params["skill"])
    end

    @character_skill = @character.character_skills.build(character_skill_params.merge(skill: skill))

    if @character_skill.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your skill could not be saved.'
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
    @character_skill = CharacterSkill.find(params[:id])
    if current_user == @character.user
      if @character_skill.destroy
        flash[:notice] = 'Skill deleted!'
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

  def character_skill_params
    params.require(:character_skill).permit(:character_id, :rating, :specialization)
  end

  def skill_params
    params.require(:character_skill).permit(:skill => [:name, :skill_group, :default_skill])
  end
end
