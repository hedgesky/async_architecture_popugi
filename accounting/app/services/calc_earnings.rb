class CalcEarnings
  def initialize(date)
    @date = date
  end

  def call
    cycles = Cycle.where(date: @date)
    transactions = Transaction.where(cycle_id: cycles.ids).non_payments
    -transactions.map(&:amount).sum
  end
end
