class Admin::ConnectionsController < ApplicationController
  def index
    sql = "SELECT connections.name,
    connections.description,
    COUNT(connections.character_id)
    FROM connections
    GROUP BY connections.name,connections.description"
    @admin_connections = ActiveRecord::Base.connection.execute(sql).to_a.sort_by{|connection| connection["count"]}.reverse!
  end
end
