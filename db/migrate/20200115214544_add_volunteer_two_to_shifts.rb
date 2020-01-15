class AddVolunteerTwoToShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :volunteer_two, :string
  end
end
