class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :balance_id, null: false
      t.integer :amount, null: false
      t.string :type, null: false
      t.text :description

      t.timestamps
    end
  end
end
