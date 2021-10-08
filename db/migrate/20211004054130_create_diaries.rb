class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :article, null: false
      t.date :date, null: false

      t.timestamps
    end

    add_foreign_key :diaries, :users, on_delete: :cascade
  end
end
