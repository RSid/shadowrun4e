class Admin::QualitiesController < ApplicationController
  def index
    @admin_qualities = Quality.all
  end
end
