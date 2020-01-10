class AddStatusToShift < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :status, :integer
  end
end
