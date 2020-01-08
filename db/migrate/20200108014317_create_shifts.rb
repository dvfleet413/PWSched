class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.string :volunteer
      t.string :location
      t.date :date
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
