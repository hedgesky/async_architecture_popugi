class AccountsCudConsumer
  QUEUE_NAME = 'auth-accounting'

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
    event_type, account_data = payload.values_at('type', 'account')

    case event_type
    when 'account_created' then account_created(account_data)
    when 'account_updated' then account_updated(account_data)
    when 'account_deleted' then account_deleted(account_data)
    else
      raise event_type
    end
  end

  def account_created(account_data)
    Rails.logger.info "Creating account: #{account_data}"
    CreateAccount.new(account_data).call
  end

  def account_updated(account_data)
    Rails.logger.info "Updating account: #{account_data}"
    Account.find(account_data['id']).update!(email: account_data['email'])
  end

  def account_deleted(account_data)
    Rails.logger.info "Deleting account: #{account_data}"
    Account.find(account_data['id']).destroy!
  end
end
