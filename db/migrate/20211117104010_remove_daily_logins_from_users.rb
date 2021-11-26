class RemoveDailyLoginsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :daily_logins, :datatype
  end
end
