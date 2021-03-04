class ApplicationController < ActionController::Base
  before_action :fake_authenticate

  private

  def fake_authenticate
    @current_user = User.find_by(id: session[:user_id])
  end

  def current_user
    @current_user
  end
end
