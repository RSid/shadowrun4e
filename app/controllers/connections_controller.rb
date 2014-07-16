class ConnectionsController < ApplicationController
  include EmptyFormObjects

  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]

  def index
    @character = Character.find(params[:character_id])
    @connection = Connection.new
  end

  def create
    @character = Character.find(params[:character_id])

    @connection = @character.connections.find_or_create_by(connection_params)

    respond_to do |format|
      format.html do
        if @connection.save
          redirect_to character_connections_path(@character)
        else
          flash.now[:notice] = 'Uh oh! Your connection could not be saved.'
          generate_empty_form_objects
          render "/connections/index"
        end
      end

      format.json do
        if @connection.save
          render json: {connection: @connection}
        else
          render json: { errors: @character.errors }
        end
      end
    end
  end

  def destroy
    @character = Character.find(params[:character_id])

    render_unauthorized unless @character.user == current_user

    @connection = @character.connections.destroy(params[:id])

      respond_to do |format|
        format.html do
          flash[:notice] = 'Skill deleted!'
          redirect_to character_connections_path(@character)
        end
        format.json do
          render json: @connection
        end
      end
  end

  private

  def connection_params
    params.require(:connection).permit(:name, :description, :loyalty, :connection)
  end
end
