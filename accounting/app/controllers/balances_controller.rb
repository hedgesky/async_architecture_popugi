class BalancesController < ApplicationController
  def show
    @balance = Balance.find(params[:id])
  end
end
