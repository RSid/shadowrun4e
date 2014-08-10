class Admin::CharactersController < ApplicationController
  def index
    @admin_characters = Character.all
  end
end
