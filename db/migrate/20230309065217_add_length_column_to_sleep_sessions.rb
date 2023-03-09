class AddLengthColumnToSleepSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sleep_sessions, :length, :integer
  end
end
