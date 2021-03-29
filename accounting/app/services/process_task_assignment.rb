class ProcessTaskAssignment
  def initialize(task_data)
    @task_data = task_data
  end

  def call
    ApplicationRecord.transaction do
      account = Account.find(task_data.assignee_id)

      assignment = TaskAssignment.create!(
        task_id: task_data.task_id,
        task_description: task_data.description,
        account_id: task_data.assignee_id
      )

      TaskAssignedTransaction.create!(
        task_assignment: assignment,
        amount: calc_cost,
        balance: account.balance
      )
    end
  end

  private

  attr_reader :task_data

  def calc_cost
    rand(-2000..-1000)
  end
end
