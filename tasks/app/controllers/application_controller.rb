class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  # Obtain fresh account data from the auth service
  def authenticate
    return redirect_to(login_url) unless session[:token_hash]

    account_data = account_data(session[:token_hash])
    @current_account = CurrentAccount.new(
      id: account_data['id'],
      email: account_data['email'],
      role: account_data['role']
    )
  rescue OAuth2::Error
    session[:token_hash] = nil
    redirect_to login_url
  end

  def current_account
    @current_account
  end
  helper_method :current_account

  def account_data(token_hash)
    client = OmniAuth.strategies.last.new(Rails.application).client
    access_token = OAuth2::AccessToken.from_hash(client, token_hash)

    access_token.get('/accounts/current').parsed
  end
end
