class AddCongregationToShift < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :congregation, :string
  end
end
