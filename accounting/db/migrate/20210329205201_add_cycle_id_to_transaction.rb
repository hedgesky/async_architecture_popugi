class AddCycleIdToTransaction < ActiveRecord::Migration[6.1]
  def up
    add_column :transactions, :cycle_id, :string
    Transaction.reset_column_information

    Transaction.find_each do |transaction|
      transaction.update!(cycle: transaction.balance.cycles.first)
    end

    remove_column :transactions, :balance_id
  end

  def down
    remove_column :transactions, :cycle_id, :string
    add_column :transactions, :balance_id, :string
  end
end
