class FinishDay
  def call
    next_date = Cycle.date_of_next_cycle

    ApplicationRecord.transaction do
      Cycle.open.each do |cycle|
        close_cycle(cycle, next_date)
      end
    end
  end

  private

  def close_cycle(cycle, next_date)
    balance = cycle.balance
    send_payment(cycle) if cycle.balance.amount.positive?
    cycle.closed!

    balance.cycles.create!(date: next_date)
  end

  def send_payment(cycle)
    amount = cycle.balance.amount
    PaymentTransaction.create!(amount: -amount, cycle: cycle)

    email = cycle.balance.account.email
    Rails.logger.info "Sent an email to #{email} with payment of #{amount}"
  end
end
