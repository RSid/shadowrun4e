class Admin::SkillsController < ApplicationController
  def index
    @admin_skills = Skill.all
    @use_count = []
    @admin_skills.each do |skill|
      @use_count << CharacterSkill.all.count(skill: skill)
    end
  end
end
