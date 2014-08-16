class Admin::QualitiesController < ApplicationController
  def index
    sql = "SELECT qualities.name, qualities.description, qualities.affected_stat, COUNT(character_qualities.quality_id) FROM qualities LEFT JOIN character_qualities ON qualities.id = character_qualities.quality_id GROUP BY qualities.name,qualities.description, qualities.affected_stat"
    @admin_qualities = ActiveRecord::Base.connection.execute(sql).to_a.sort_by{|quality| quality["count"]}.reverse!
  end
end
