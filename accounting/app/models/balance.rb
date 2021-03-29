class Balance < ApplicationRecord
  belongs_to :account

  has_many :cycles

  def amount
    transactions.sum(:amount)
  end

  def transactions
    Transaction.where(cycle_id: cycles.ids)
  end

  def current_cycle
    cycles.order(date: :desc).first
  end
end
