class UpdateForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :sessions, :users
    add_foreign_key :sessions, :users, on_delete: :cascade, null: false
  end
end
