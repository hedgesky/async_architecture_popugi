class Consumers::TasksBe
  QUEUE_NAME = 'be_tasks_to_accounting'
  EXCHANGE_NAME = 'be-tasks'
  TaskData = Struct.new(:task_id, :description, :assignee_id)

  def initialize
    @queue = RabbitQueue.new(QUEUE_NAME, EXCHANGE_NAME)
  end

  def subscribe
    @queue.subscribe { |payload| process_event(payload) }

    self
  end

  private

  def process_event(payload)
    event_type, raw = payload.values_at('type', 'task')
    task_data = TaskData.new(*raw.values_at('task_id', 'description', 'assignee_id'))
    Rails.logger.info "Processing '#{event_type}' event: #{task_data}"

    case event_type
    when 'task_assigned' then ProcessTaskAssignment.new(task_data).call
    when 'task_completed' then ProcessTaskCompletion.new(task_data).call
    end
  rescue => e
    puts "Something happened during processing #{event_type}: #{e.class}: #{e.message}"
  end
end
