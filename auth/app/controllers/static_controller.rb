class StaticController < ApplicationController
  def not_authorized
    redirect_to new_account_session_path unless current_account
  end
end