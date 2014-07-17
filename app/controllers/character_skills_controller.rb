class CharacterSkillsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character_skills = @character.character_skills

    @skill = Skill.new
    @character_skill = CharacterSkill.new
  end

  def create
    skill = Skill.find_or_create_by(skill_params["skill"])

    @character_skill = @character.character_skills.build(character_skill_params.merge(skill: skill))

    respond_to_create('skill',@character_skill, @character)
  end

  def destroy
    respond_to_destroy('skill', params[:id], @character)
  end

  private

  def character_skill_params
    params.require(:character_skill).permit(:character_id, :rating, :specialization)
  end

  def skill_params
    params.require(:character_skill).permit(:skill => [:name, :skill_group, :default_skill])
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
