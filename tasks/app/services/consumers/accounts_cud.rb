class Consumers::AccountsCud
  QUEUE_NAME = 'cud_auth_to_tasks'
  EXCHANGE_NAME = 'cud_auth'

  def initialize
    @queue = RabbitQueue.new(QUEUE_NAME, EXCHANGE_NAME)
  end

  def subscribe
    queue.subscribe { |payload| process_event(payload) }

    self
  end

  private

  attr_reader :queue

  def process_event(payload)
    event_type, account_data = payload.values_at('type', 'account')
    Rails.logger.info "Processing '#{event_type}' event: #{account_data}"

    case event_type
    when 'account_created'
      Account.create!(account_data)
    when 'account_updated'
      Account.find(account_data['id']).update!(email: account_data['email'])
    when 'account_deleted'
      Account.find(account_data['id']).destroy!
    end
  rescue => e
    puts "Something happened during processing #{event_type}: #{e.class}: #{e.message}"
  end
end
