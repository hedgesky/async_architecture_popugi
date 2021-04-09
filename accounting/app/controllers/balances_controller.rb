class BalancesController < ApplicationController
  def show
    @balance = Balance.find(params[:id])
    @transactions = @balance.transactions
    @earned_today = CalcEarnedToday.new(@balance).call

    preload_transaction_associations
  end

  private

  def preload_transaction_associations
    preloader = ActiveRecord::Associations::Preloader.new

    preloader.preload(
      @transactions.select { |t| t.is_a?(TaskAssignedTransaction) }, :task_assignment
    )

    preloader.preload(
      @transactions.select { |t| t.is_a?(TaskCompletedTransaction) }, :task_completion
    )
  end
end
