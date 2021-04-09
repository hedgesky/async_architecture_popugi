class Producers::AccountingBe
  EXCHANGE_NAME = 'be-accounting'

  def self.balance_cycle_closed(cycle:)
    publish(
      type: 'balance_cycle_closed',
      transactions: transactions_data(cycle),
      account_id: cycle.balance.account_id,
      total: cycle.total
    )
  end

  def self.payment_sent(cycle:, amount:)
    publish(
      type: 'payment_sent',
      cycle_id: cycle.id,
      account_id: cycle.balance.account_id,
      amount: amount
    )
  end

  class << self
    private

    def transactions_data(cycle)
      cycle.transactions.map do |transaction|
        {
          amount: transaction.amount,
          type: transaction.type,
          description: transaction.description
        }
      end
    end

    def exchange
      @exchange ||= RabbitExchange.new(EXCHANGE_NAME)
    end

    def publish(payload)
      exchange.publish(payload)
    end
  end
end
