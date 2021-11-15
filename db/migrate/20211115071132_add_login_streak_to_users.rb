class AddLoginStreakToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login_streak, :integer
  end
end
