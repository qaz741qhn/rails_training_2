class AddMonthlyLoginsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :daily_logins, :integer
  end
end
