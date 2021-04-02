class BalancesController < ApplicationController
  def show
    @balance = Balance.find(params[:id])
    @earned_today = CalcEarnedToday.new(@balance).call
  end
end
