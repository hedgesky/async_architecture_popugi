class Balance < ApplicationRecord
  belongs_to :account

  has_many :transactions

  def amount
    transactions.sum(:amount)
  end
end
