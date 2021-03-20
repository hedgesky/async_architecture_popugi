class SessionsController < ActionController::Base
  layout false

  def new
  end

  def create
    auth_data = request.env['omniauth.auth']
    session[:account] = {
      id: auth_data['uid'],
      email: auth_data.dig('info', 'email'),
      role: auth_data.dig('info', 'role')
    }
    redirect_to root_url
  end

  def destroy
    session[:account] = nil
    redirect_to root_url
  end
end