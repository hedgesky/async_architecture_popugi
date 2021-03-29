class TasksBeConsumer
  QUEUE_NAME = 'be-tasks'
  TaskData = Struct.new(:task_id, :description, :assignee_id)

  def sync
    amount = 0

    loop do
      payload = RabbitQueue.new(QUEUE_NAME).pop
      break unless payload

      process_event(payload)
      amount += 1
    end

    Rails.logger.info "Processed #{amount} events from #{QUEUE_NAME}"
  end

  private

  attr_reader :queue

  def process_event(payload)
    event_type, raw = payload.values_at('type', 'task')
    task_data = TaskData.new(*raw.values_at('task_id', 'description', 'assignee_id'))

    case event_type
    when 'task_assigned' then task_assigned(task_data)
    when 'task_completed' then task_completed(task_data)
    end
  end

  def task_assigned(task_data)
    Rails.logger.info "Processing 'task assigned' event: #{task_data}"
    ProcessTaskAssignment.new(task_data).call
  end

  def task_completed(task_data)
    Rails.logger.info "Processing 'task completed' event: #{task_data}"
    ProcessTaskCompletion.new(task_data).call
  end
end
