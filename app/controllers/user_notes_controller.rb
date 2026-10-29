class UserNotesController < ApplicationController
  def index
    user = User.find(params[:user_id])

    notes = Note
      .joins(:team)
      .where(team: user.teams)
      .distinct

    render json: notes
  end
end