class Task < ApplicationRecord
  belongs_to :project
  acts_as_list scope: :project
  default_scope -> { order(position: :desc) }
  scope :recent_first, -> { order(created_at: :desc) }
  validates :name, presence: true
end
