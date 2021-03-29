class Cycle < ApplicationRecord
  enum state: [:open, :closed]

  belongs_to :balance

  has_many :transactions

  def self.date_of_next_cycle
    Cycle.open.pluck(:date).max + 1.day
  end
end
