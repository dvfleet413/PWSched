class Shift < ApplicationRecord
  validates :location, presence: true

  enum status: [:available, :requested, :assigned]

  def start_time
    self.date
  end

end
