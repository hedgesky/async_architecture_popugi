class AccountsController < ApplicationController
  before_action :authorize!
  before_action :set_account, only: [:edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    result, @account = CreateAccount.call(attributes: account_params)

    if result
      redirect_to accounts_url, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    attrs = account_params
    attrs.delete(:password) if attrs[:password].blank?
    if UpdateAccount.call(account: @account, attributes: attrs)
      redirect_to accounts_url, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    DeleteAccount.call(account: @account)
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def authorize!
    unless current_account&.admin?
      redirect_to new_account_session_path
      return
    end

    true
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email, :role, :password)
  end
end
