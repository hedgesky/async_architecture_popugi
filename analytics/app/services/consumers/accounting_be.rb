class Consumers::AccountingBe
  QUEUE_NAME = 'be_accounting_to_analytics'
  EXCHANGE_NAME = 'be-accounting'

  def initialize
    @queue = RabbitQueue.new(QUEUE_NAME, EXCHANGE_NAME)
  end

  def subscribe
    @queue.subscribe { |payload| process_event(payload) }

    self
  end

  private

  def process_event(payload)
    event_type = payload['type']
    Rails.logger.info "\n\nProcessing '#{event_type}' event: #{payload}\n\n"

    case event_type
    when 'task_completion_cost_set' then task_completion_cost_set(payload)
    when 'balance_cycle_closed' then balance_cycle_closed(payload)
    end
  rescue => e
    puts "Something happened during processing #{event_type}: #{e.class}: #{e.message}"
  end

  def task_completion_cost_set(payload)
    ClosedTask.create(
      task_id: payload['task_id'],
      description: payload['task_description'],
      assignee_id: payload['assignee_id'],
      completion_cost: payload['completion_cost'],
      date: payload['date']
    )
  end

  def balance_cycle_closed(payload)
    PopugEarning.create!(
      account_id: payload['account_id'],
      date: payload['date'],
      amount: payload['total']
    )
  end
end
