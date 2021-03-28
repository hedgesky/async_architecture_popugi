class UpdateTask
  def initialize(task:, attributes:)
    @task = task
    @attributes = attributes
  end

  def call
    if @task.update(@attributes)
      NotifyAssignee.call(task: @task)
      true
    else
      false
    end
  end
end
