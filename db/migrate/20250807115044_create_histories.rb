class CreateHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :histories do |t|
      t.string :from_status
      t.string :to_status
      t.references :user, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.string :action, null: false
      t.text :changes, null: false
      
      t.timestamps
    end
  end
end
