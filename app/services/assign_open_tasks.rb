class AssignOpenTasks
  def call
    Task.open.find_each do |task|
      task.update!(assignee_id: available_users.sample.id)
    end
  end

  private

  def available_users
    @available_users ||= User.all
  end
end
