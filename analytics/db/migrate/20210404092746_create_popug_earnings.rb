class CreatePopugEarnings < ActiveRecord::Migration[6.1]
  def change
    create_table :popug_earnings, id: :uuid do |t|
      t.string :account_id, null: false
      t.date :date, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
