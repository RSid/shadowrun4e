class CharacterSkillsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper

  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character = Character.find(params[:character_id])
    @character_skills = @character.character_skills

    @skill = Skill.new
    @character_skill = CharacterSkill.new
  end

  def create
    @character = Character.find(params[:character_id])

    skill = Skill.find_or_create_by(skill_params["skill"])

    @character_skill = @character.character_skills.build(character_skill_params.merge(skill: skill))

    respond_to_create('skill',@character_skill, @character)
  end

  def destroy
    @character = Character.find(params[:character_id])

    render_unauthorized unless @character.user == current_user

    @character_skill = @character.character_skills.destroy(params[:id])

      respond_to do |format|
        format.html do
          flash[:notice] = 'Skill deleted!'
          redirect_to character_character_skills_path(@character)
        end
        format.json do
          render json: @character_skill
        end
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
