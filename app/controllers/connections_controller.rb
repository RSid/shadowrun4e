class ConnectionsController < ApplicationController
  include EmptyFormObjects
  include CreatorHelper
  include DestroyerHelper

  before_action :set_character
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character = Character.find(params[:character_id])
    @connection = Connection.new
  end

  def create
    # @character = Character.find(params[:character_id])

    @connection = @character.connections.find_or_create_by(connection_params)

    respond_to_create('connection',@connection, @character)
  end

  def destroy
    respond_to_destroy('connection', params[:id], @character)
  end

  private

  def connection_params
    params.require(:connection).permit(:name, :description, :loyalty, :connection)
  end

  def set_character
    @character = Character.find(params[:character_id])
  end
end
