class Project < ApplicationRecord
  belongs_to :user
  has_many :task
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
end