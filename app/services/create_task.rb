class CreateTask
  def initialize(attributes:)
    @attributes = attributes
  end

  def call
    task = Task.new(@attributes)

    if task.save
      NotifyAssignee.new(task: task).call if task.assignee_id
      [true, task]
    else
      [false, task]
    end
  end
end