class Transaction < ApplicationRecord
  belongs_to :cycle

  scope :non_payments, -> { where.not(type: PaymentTransaction.name) }
end
