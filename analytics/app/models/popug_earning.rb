class PopugEarning < ApplicationRecord
  belongs_to :account

  def self.latest
    where(date: date_of_last_closed_cycle)
  end

  def self.date_of_last_closed_cycle
    PopugEarning.maximum(:date)
  end
end
