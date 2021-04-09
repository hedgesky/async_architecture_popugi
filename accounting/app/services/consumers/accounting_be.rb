class Consumers::AccountingBe
  QUEUE_NAME = 'be_accounting_to_accounting'
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
    when 'payment_sent'
      cycle = Cycle.find(payload['cycle_id'])
      email = cycle.balance.account.email
      amount = payload['amount']
      Rails.logger.info "\n\nSent an email to #{email} with payment of #{amount}\n\n"
    end
  rescue => e
    puts "Something happened during processing #{event_type}: #{e.class}: #{e.message}"
  end
end
