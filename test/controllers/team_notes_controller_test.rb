require "test_helper"

class TeamNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = teams(:one)
  end

  test "returns notes for a valid team" do
    get team_notes_url(@team), as: :json
    assert_response :success
    assert_kind_of Array, response.parsed_body
  end

  test "returns 404 for a missing team" do
    get team_notes_url(team_id: 0), as: :json
    assert_response :not_found
  end
end