class Task < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name
  validate :valid_due_date?

  def valid_due_date?
    if end_time.blank? || end_time < (created_at || Time.zone.now)
      errors.add(:end_time, "must be greater than the current time")
    end
  end
end
