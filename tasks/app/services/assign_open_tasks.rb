class AssignOpenTasks
  def call
    Task.open.find_each do |task|
      attributes = { assignee_id: available_accounts.sample.id }
      UpdateTask.new(task: task, attributes: attributes).call
      Producers::TasksBe.task_assigned(task)
    end
  end

  private

  def available_accounts
    @available_accounts ||= Account.all
  end
end
