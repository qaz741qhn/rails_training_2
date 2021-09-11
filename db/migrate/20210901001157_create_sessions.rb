class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true, null: false, on_delete: :cascade
      t.string :token_digest
      t.datetime :expires_at

      t.timestamps
    end

    add_index :sessions, [:token_digest], unique: true
  end
end
