class DashboardController < ApplicationController
  def index
    earnings = PopugEarning.latest
    @today_earnings_total = -earnings.sum(:amount)
    @popugs_owing_money_amount = earnings.count { |t| t.amount.negative? }


    @most_expensive_task_in_day = most_expensive_task_in(1)
    @most_expensive_task_in_week = most_expensive_task_in(7)
    @most_expensive_task_in_month = most_expensive_task_in(31)
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

  def most_expensive_task_in(days_amount)
    latest_date = PopugEarning.date_of_last_closed_cycle
    ClosedTask
      .where('date >= ?', latest_date - days_amount.days)
      .order(completion_cost: :desc)
      .first
  end
end
