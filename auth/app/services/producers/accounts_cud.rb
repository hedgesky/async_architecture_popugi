class Producers::AccountsCud
  EXCHANGE_NAME = 'cud_auth'

  def self.account_created(account)
    send_message(
      type: 'account_created', account: to_attrs(account)
    )
  end

  def self.account_updated(account)
    send_message(
      type: 'account_updated', account: to_attrs(account)
    )
  end

  def self.account_deleted(account)
    send_message(
      type: 'account_deleted', account: to_attrs(account)
    )
  end

  class << self
    private

    def to_attrs(account)
      account.attributes.slice('id', 'email')
    end

    def exchange
      @exchange ||= RabbitExchange.new(EXCHANGE_NAME)
    end

    def send_message(payload)
      exchange.publish(payload)
    end
  end
end
