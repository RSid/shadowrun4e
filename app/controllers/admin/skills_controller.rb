class Admin::SkillsController < ApplicationController
  def index
    @admin_skills = Skill.all
  end
end
