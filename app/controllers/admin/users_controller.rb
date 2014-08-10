class Admin::UsersController < ApplicationController
  def index
    @admin_users = User.all
  end
end
