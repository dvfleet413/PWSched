class AddRequestByToShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :request_by, :text, array: true, default: []
  end
end
