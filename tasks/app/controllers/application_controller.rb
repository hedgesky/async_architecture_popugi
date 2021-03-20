class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    if session[:account]
      @current_account = Account.new(
        id: session[:account]['id'],
        email: session[:account]['email'],
        role: session[:account]['role']
      )
    else
      redirect_to '/login'
    end
  end

  def current_account
    @current_account
  end
  helper_method :current_account
end
