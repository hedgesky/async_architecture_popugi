class EventProducer
  def self.task_assigned(task)
    send_message(
      type: 'task_assigned', task: to_attrs(task)
    )
  end

  def self.task_completed(task)
    send_message(
      type: 'task_completed', task: to_attrs(task)
    )
  end

  class << self
    private

    def to_attrs(task)
      {
        task_id: task.id,
        description: task.description,
        assignee_id: task.assignee_id
      }
    end

    def send_message(payload)
      RabbitQueue.new('be-tasks').push(payload)
    end
  end
end
