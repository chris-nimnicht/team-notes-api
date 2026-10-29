require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @team = teams(:one)
    @user = users(:one)
  end

  test "valid with all required fields" do
    note = Note.new(title: "Title", content: "Body", team: @team, created_by_user: @user)
    assert note.valid?
  end

  test "invalid without title" do
    note = Note.new(content: "Body", team: @team, created_by_user: @user)
    assert_not note.valid?
    assert_includes note.errors[:title], "can't be blank"
  end

  test "invalid without content" do
    note = Note.new(title: "Title", team: @team, created_by_user: @user)
    assert_not note.valid?
    assert_includes note.errors[:content], "can't be blank"
  end

  test "invalid without team" do
    note = Note.new(title: "Title", content: "Body", created_by_user: @user)
    assert_not note.valid?
  end

  test "invalid without created_by_user" do
    note = Note.new(title: "Title", content: "Body", team: @team)
    assert_not note.valid?
  end
end
