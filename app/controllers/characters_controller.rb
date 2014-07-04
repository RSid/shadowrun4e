class CharactersController < ApplicationController

  def index
    if user_signed_in?
      @users_characters = current_user.characters
    end
  end

  def show
    
  end

  def new
  end

  def create
  end

  private

  def character_params
  end
end
