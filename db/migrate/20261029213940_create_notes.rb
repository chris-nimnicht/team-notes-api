class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :team, null: false, foreign_key: true
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
