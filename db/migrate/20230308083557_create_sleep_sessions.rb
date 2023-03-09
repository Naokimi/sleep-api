class CreateSleepSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_sessions do |t|
      t.datetime :ended_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
