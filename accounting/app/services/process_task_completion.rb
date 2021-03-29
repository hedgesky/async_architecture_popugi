class ProcessTaskCompletion
  def initialize(task_data)
    @task_data = task_data
  end

  def call
    ApplicationRecord.transaction do
      account = Account.find(task_data.assignee_id)

      completion = TaskCompletion.create!(
        task_id: task_data.task_id,
        task_description: task_data.description,
        account_id: task_data.assignee_id
      )

      TaskCompletedTransaction.create!(
        task_completion: completion,
        amount: calc_cost,
        cycle: account.balance.current_cycle
      )
    end
  end

  private

  attr_reader :task_data

  def calc_cost
    rand(2000..4000)
  end
end
