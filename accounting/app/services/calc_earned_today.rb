class CalcEarnedToday
  def initialize(balance)
    @balance = balance
  end

  def call
    transactions = Cycle.open.find_by(balance: @balance).transactions
    transactions.sum(:amount)
  end
end
