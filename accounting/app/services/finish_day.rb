class FinishDay
  def call
    next_date = Cycle.date_of_next_cycle

    ApplicationRecord.transaction do
      Cycle.open.includes(:transactions).each do |cycle|
        close_cycle(cycle, next_date)
      end
    end
  end

  private

  def close_cycle(cycle, next_date)
    balance = cycle.balance
    send_payment(cycle) if cycle.balance.amount.positive?
    cycle.closed!
    Producers::AccountingBe.balance_cycle_closed(cycle: cycle)

    balance.cycles.create!(date: next_date)
  end

  def send_payment(cycle)
    amount = cycle.balance.amount
    PaymentTransaction.create!(amount: -amount, cycle: cycle)

    Producers::AccountingBe.payment_sent(cycle: cycle, amount: amount)
  end
end
