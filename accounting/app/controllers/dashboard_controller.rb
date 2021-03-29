class DashboardController < ApplicationController
  def index
    @accounts = Account.all.includes(:balance)
  end
end
