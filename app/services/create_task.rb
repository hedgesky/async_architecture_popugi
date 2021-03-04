class CreateTask
  def initialize(attributes:)
    @attributes = attributes
  end

  def call
    task = Task.new(@attributes)

    if task.save
      NotifyAssignee.call(task: task) if task.assignee_id.present?
      [true, task]
    else
      [false, task]
    end
  end
end