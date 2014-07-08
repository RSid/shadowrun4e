class PagesController < ApplicationController
  layout "static"

  def landing
    if user_signed_in?
      redirect_to(characters_path)
    end
  end

  def about

  end
end
