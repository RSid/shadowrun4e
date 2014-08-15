class Admin::SkillsController < ApplicationController
  def index
    sql = "SELECT skills.name, skills.default_skill, skills.skill_group, COUNT(character_skills.skill_id) FROM skills LEFT JOIN character_skills ON skills.id = character_skills.skill_id GROUP BY skills.name,skills.default_skill, skills.skill_group"
    @admin_skills = ActiveRecord::Base.connection.execute(sql).to_a.sort_by{|skill| skill["count"]}.reverse!
  end
end
