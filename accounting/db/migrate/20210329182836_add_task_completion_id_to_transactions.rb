class AddTaskCompletionIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :task_completion_id, :string
    add_column :transactions, :task_assignment_id, :string
  end
end
