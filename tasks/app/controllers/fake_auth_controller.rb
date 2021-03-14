class FakeAuthController < ApplicationController
  def login
    session[:user_id] = params[:user_id]
    redirect_to root_url, notice: "Authenticated as #{session[:user_id]}"
  end
end
