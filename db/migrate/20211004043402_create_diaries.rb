class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true, on_delete: :cascade, null: false
      t.string :title, null: false
      t.text :article, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
