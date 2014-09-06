class PagesController < ApplicationController
  layout "static", only: [:landing, :about]

  def landing
    if user_signed_in?
      redirect_to(characters_path)
    end
  end
end
