class AddNotNullToNotesTitleAndContent < ActiveRecord::Migration[7.1]
  def change
    change_column_null :notes, :title, false
    change_column_null :notes, :content, false
  end
end
