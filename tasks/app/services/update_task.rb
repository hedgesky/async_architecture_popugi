class UpdateTask
  def initialize(task:, attributes:)
    @task = task
    @attributes = attributes
  end

  def call
    if @task.update(@attributes)
      true
    else
      false
    end
  end
end
