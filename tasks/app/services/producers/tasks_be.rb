class Producers::TasksBe
  EXCHANGE_NAME = 'be-tasks'

  def self.task_assigned(task)
    publish(
      type: 'task_assigned', task: to_attrs(task)
    )
  end

  def self.task_completed(task)
    publish(
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

    def exchange
      @exchange ||= RabbitExchange.new(EXCHANGE_NAME)
    end

    def publish(payload)
      exchange.publish(payload)
    end
  end
end
