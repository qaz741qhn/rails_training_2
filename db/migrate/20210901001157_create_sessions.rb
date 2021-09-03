class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :users, foreign_key: true, null: false
      t.string :token_digest
      t.datetime :expired_at

      t.timestamps
    end

    add_index :sessions, [:token_digest], unique: true
  end
end
