class DashboardController < ApplicationController
  def index
  end

  private

  def fetch_earnings
    current_day = Cycle.date_of_cyrrent_cycle
    week_ago = current_day - 7.days

    hash = {}
    (week_ago .. current_day).each do |date|
      hash[date] = CalcCompanyEarnings.new(date).call
    end
    hash
  end
end
