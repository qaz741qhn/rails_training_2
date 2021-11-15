class RemoveLoginStreakFromSessions < ActiveRecord::Migration[6.1]
  def change
    remove_column :sessions, :login_streak, :datatype
  end
end
