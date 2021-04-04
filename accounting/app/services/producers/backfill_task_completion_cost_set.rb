class BackfillTaskCompletionCostSet
  def call
    TaskCompletedTransaction.includes(:task_completion).find_each do |transaction|
      completion = transaction.task_completion
      task_data = Consumers::TasksBe::TaskData.new(
        completion.task_id, completion.task_description, completion.account_id
      )

      Producers::AccountingBe.task_completion_cost_set(
        task_data: task_data, transaction: transaction
      )
    end
  end
end
