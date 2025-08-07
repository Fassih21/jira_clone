class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :status

      t.references :user, null: false, foreign_key: true
      t.references :dev, null: false, foreign_key: { to_table: :users }
      t.references :qa, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
