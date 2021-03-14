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
    @account = Account.new(account_params)

    if @account.save
      redirect_to accounts_url, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_url, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def authorize!
    unless current_auth_admin_account
      redirect_to new_auth_admin_account_session_path
      return
    end

    true
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email, :role)
  end
end
