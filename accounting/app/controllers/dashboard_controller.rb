class DashboardController < ApplicationController
  def index
    @accounts = Account.all.includes(balance: :transactions)
  end
end
