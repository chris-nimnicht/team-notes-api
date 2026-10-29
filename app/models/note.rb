class Note < ApplicationRecord
  belongs_to :team
  belongs_to :created_by_user, class_name: "User"

  validates :title, presence: true
  validates :content, presence: true
end
