class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.string :phone
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
