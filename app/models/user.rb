class User < ApplicationRecord
  has_many :team_memberships
  has_many :teams, through: :team_memberships

  has_many :notes, foreign_key: :created_by_user_id
end
