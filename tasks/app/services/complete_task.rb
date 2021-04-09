class CompleteTask
  def initialize(task:)
    @task = task
  end

  def call
    UpdateTask.new(task: @task, attributes: { state: :done }).call
    Producers::TasksBe.task_completed(@task)
  end
end
