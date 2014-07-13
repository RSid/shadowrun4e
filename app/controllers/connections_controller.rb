class ConnectionsController < ApplicationController
  include EmptyFormObjects

  def index
    @character = Character.find(params[:character_id])
    @connection = Connection.new
  end

  def create
    @character = Character.find(params[:character_id])

    @connection = @character.connections.find_or_create_by(connection_params)

    if @connection.save
      redirect_to character_connections_path(@character)
    else
      flash.now[:notice] = 'Uh oh! Your connection could not be saved.'
      generate_empty_form_objects
      render "/connections/index"
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @connection = Connection.find(params[:id])
    if current_user == @character.user
      if @connection.destroy
        flash[:notice] = 'Connection deleted!'
        redirect_to character_connections_path(@character)
      end
    else
      flash.now[:notice] = 'You are not logged in. You must be logged in to edit a character.'
      generate_empty_form_objects
      render "/connections/index"
    end
  end

  private

  def connection_params
    params.require(:connection).permit(:name, :description, :loyalty, :connection)
  end
end
