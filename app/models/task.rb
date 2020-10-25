class Task < ApplicationRecord
  belongs_to :project
  acts_as_list scope: :project
  default_scope -> { order(position: :desc) }
  scope :recent_first, -> { order(created_at: :desc) }
  validates :name,:start_time, :end_time, presence: true
  validate :end_date_after_start_date


  private

  def end_date_after_start_date
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, 'must be after the start date') if end_time < start_time
    errors.add(:start_time, 'must be after the start date') if start_time > end_time
  end
end
