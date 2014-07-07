class SkillsController < ApplicationController

  def new
    @skill = Skill.new
  end

  def create
    binding.pry
    @character = Character.find(params[:id])
    @skill = current_user.skills.build(skill_params)

    if @skill.save
      redirect_to character_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your skill could not be saved.'
      render :new
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :skill_group, :default_skill)
  end
end
