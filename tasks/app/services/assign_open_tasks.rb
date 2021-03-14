class AssignOpenTasks
  def call
    Task.open.find_each do |task|
      attributes = { assignee_id: available_users.sample.id }
      UpdateTask.new(task: task, attributes: attributes).call
    end
  end

  private

  def available_users
    @available_users ||= User.all
  end
end
