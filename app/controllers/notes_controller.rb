class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]

  # POST /notes
  def create
    note = Note.new(note_params)

    if note.save
      render json: note, status: :created
    else
      render json: {
        errors: note.errors.full_messages
      }, status: :unprocessable_content
    end
  end

  # GET /notes/:id
  def show
    render json: @note
  end

  # PATCH /notes/:id
  # PUT /notes/:id
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: {
        errors: @note.errors.full_messages
      }, status: :unprocessable_content
    end
  end

  # DELETE /notes/:id
  def destroy
    @note.destroy
    head :no_content
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(
      :title,
      :content,
      :team_id,
      :created_by_user_id
    )
  end
end