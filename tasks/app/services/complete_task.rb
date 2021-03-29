class CompleteTask
  def initialize(task:)
    @task = task
  end

  def call
    UpdateTask.new(task: @task, attributes: { state: :done }).call
    EventProducer.task_completed(@task)
  end
end
