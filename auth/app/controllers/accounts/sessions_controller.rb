# frozen_string_literal: true

class Accounts::SessionsController < Devise::SessionsController
  def destroy
    current_account.access_tokens.delete_all
    super
  end
end
