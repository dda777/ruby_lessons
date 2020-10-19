class Project < ApplicationRecord
  belongs_to :user
  has_many :task, dependent: :delete_all
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
end
