class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances, id: :uuid do |t|
      t.integer :amount, null: false
      t.string :account_id, null: false

      t.timestamps
    end
  end
end
