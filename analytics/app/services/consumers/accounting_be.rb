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
    Rails.logger.info "Processing '#{event_type}' event: #{payload}"

    case event_type
    when 'task_cost_set'
    when 'balance_cycle_closed'

    end
  rescue => e
    puts "Something happened during processing #{event_type}: #{e.class}: #{e.message}"
  end
end
