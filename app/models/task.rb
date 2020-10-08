class Task < ApplicationRecord
  belongs_to :project
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
end
