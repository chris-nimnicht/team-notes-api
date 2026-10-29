require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note = notes(:one)
    @team = teams(:one)
    @user = users(:one)
  end

  # POST /notes
  test "creates a note with valid params" do
    assert_difference("Note.count") do
      post notes_url, params: {
        note: { title: "New Note", content: "Body text", team_id: @team.id, created_by_user_id: @user.id }
      }, as: :json
    end
    assert_response :created
  end

  test "returns 422 when title is missing" do
    post notes_url, params: {
      note: { content: "Body", team_id: @team.id, created_by_user_id: @user.id }
    }, as: :json
    assert_response :unprocessable_content
    assert_not_empty response.parsed_body["errors"]
  end

  test "returns 422 when content is missing" do
    post notes_url, params: {
      note: { title: "Title", team_id: @team.id, created_by_user_id: @user.id }
    }, as: :json
    assert_response :unprocessable_content
  end

  test "returns 422 when team_id is invalid" do
    post notes_url, params: {
      note: { title: "Title", content: "Body", team_id: 0, created_by_user_id: @user.id }
    }, as: :json
    assert_response :unprocessable_content
  end

  # GET /notes/:id
  test "shows a note" do
    get note_url(@note), as: :json
    assert_response :success
  end

  test "returns 404 for a missing note" do
    get note_url(id: 0), as: :json
    assert_response :not_found
  end

  # PATCH /notes/:id
  test "updates a note with valid params" do
    patch note_url(@note), params: { note: { title: "Updated" } }, as: :json
    assert_response :success
    assert_equal "Updated", response.parsed_body["title"]
  end

  test "returns 422 when updating with blank title" do
    patch note_url(@note), params: { note: { title: "" } }, as: :json
    assert_response :unprocessable_content
    assert_not_empty response.parsed_body["errors"]
  end

  test "returns 404 when updating a missing note" do
    patch note_url(id: 0), params: { note: { title: "x" } }, as: :json
    assert_response :not_found
  end

  # DELETE /notes/:id
  test "destroys a note" do
    assert_difference("Note.count", -1) do
      delete note_url(@note), as: :json
    end
    assert_response :no_content
  end

  test "returns 404 when deleting a missing note" do
    delete note_url(id: 0), as: :json
    assert_response :not_found
  end
end