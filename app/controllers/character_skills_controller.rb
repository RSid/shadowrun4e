class CharacterSkillsController < ApplicationController

  def new
    @character_skill = CharacterSkill.new
    @skill = Skill.new
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
      render :show
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
