class AddLoginStreakToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :login_streak, :integer
  end
end
