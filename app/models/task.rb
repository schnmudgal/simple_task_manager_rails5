class Task < ApplicationRecord

  # Assocations
  belongs_to :user

  # Validations
  validates :start, :end, :description, presence: true
  validates :start_is_less_than_end

  # Private instance methods
  def start_is_less_than_end
    if self.start > self.end
      errors.add(:start, 'must be before end time.')
    end
  end

end
