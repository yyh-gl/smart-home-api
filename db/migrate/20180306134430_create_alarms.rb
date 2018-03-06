class CreateAlarms < ActiveRecord::Migration[5.1]
  def change
    create_table :alarms do |t|
      t.datetime :reservation_date

      t.timestamps
    end
  end
end
