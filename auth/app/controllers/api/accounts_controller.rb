module Api
  class AccountsController < ApplicationController
    http_basic_authenticate_with name: ENV['API_LOGIN'], password: ENV['API_PASSWORD']

    def show
      account = Account.find(params[:id])
      account_data = {
        id: account.id,
        email: account.email,
        role: account.role,
        phone: account.phone,
        slack: account.slack
      }
      render json: account_data
    end
  end
end
