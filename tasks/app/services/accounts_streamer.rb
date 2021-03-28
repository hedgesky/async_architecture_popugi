class AccountsStreamer
  def initialize
    @queue = connect_to_queue
  end

  def sync
    loop do
      _, _, payload = queue.pop
      return unless payload

      process_event(payload)
    end
  end

  private

  attr_reader :queue

  def process_event(payload)
    event_type, account_data = JSON.parse(payload).values_at('type', 'account')

    case event_type
    when 'account_created' then account_created(account_data)
    when 'account_updated' then account_updated(account_data)
    when 'account_deleted' then account_deleted(account_data)
    end
  end

  def account_created(account_data)
    Rails.logger.info "Creating account: #{account_data}"
    Account.create!(account_data)
  end

  def account_updated(account_data)
    Rails.logger.info "Updating account: #{account_data}"
    Account.find(account_data['id']).update!(email: account_data['email'])
  end

  def account_deleted(account_data)
    Rails.logger.info "Deleting account: #{account_data}"
    Account.find(account_data['id']).destroy!
  end

  def connect_to_queue
    conn = Bunny.new
    conn.start
    conn.create_channel.queue('auth-tasks')
  end
end
