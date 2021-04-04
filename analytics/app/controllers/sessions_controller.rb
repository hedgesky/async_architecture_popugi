class SessionsController < ActionController::Base
  layout false

  def new
  end

  # Store token in session: we'll use it later to obtain fresh account data on each
  # request through the auth service
  def create
    access_token = request.env['omniauth.auth'].dig('info', 'token')
    session[:token_hash] = access_token.to_hash
    redirect_to root_url
  end

  def destroy
    session[:token_hash] = nil
    redirect_to root_url
  end
end
