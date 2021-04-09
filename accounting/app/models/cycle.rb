class Cycle < ApplicationRecord
  enum state: [:open, :closed]

  belongs_to :balance

  has_many :transactions

  def self.date_of_cyrrent_cycle
    Cycle.open.pluck(:date).max
  end

  def self.date_of_next_cycle
    date_of_cyrrent_cycle + 1.day
  end

  def total
    transactions.map(&:amount).sum
  end
end
