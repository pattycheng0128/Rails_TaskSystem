class Task < ApplicationRecord
  include AASM
  validates :name, presence: true
  validate :valid_due_date?
  belongs_to :user

  aasm column: 'state' do # default column: aasm_state
    state :pending, initial: true 
    state :progressing, :done

    event :progress do
      transitions from: :pending, to: :progressing
    end

    event :end do
      transitions from: :progressing, to: :done
    end
  end

  private
  def valid_due_date?
    if end_time.blank? || end_time < (created_at || Time.zone.now)
      errors.add(:end_time, "must be greater than the current time")
    end
  end
  
end
