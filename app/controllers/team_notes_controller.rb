class TeamNotesController < ApplicationController
  def index
    team = Team.find(params[:team_id])

    render json: team.notes
  end
end