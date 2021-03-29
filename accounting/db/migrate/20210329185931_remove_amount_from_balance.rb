class RemoveAmountFromBalance < ActiveRecord::Migration[6.1]
  def change
    remove_column :balances, :amount, :integer, default: 0
  end
end
