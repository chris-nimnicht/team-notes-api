require "test_helper"

class UserNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "returns notes for a valid user" do
    get user_notes_url(@user), as: :json
    assert_response :success
    assert_kind_of Array, response.parsed_body
  end

  test "returns 404 for a missing user" do
    get user_notes_url(user_id: 0), as: :json
    assert_response :not_found
  end
end