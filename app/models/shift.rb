class Shift < ApplicationRecord
  validates :location, presence: true

  enum status: [:available, :requested, :assigned]

end
