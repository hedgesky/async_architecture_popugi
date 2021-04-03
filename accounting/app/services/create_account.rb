class CreateAccount
  def initialize(account_data)
    @account_data = account_data
  end

  def call
    account = Account.create!(@account_data)
    balance = Balance.create!(account: account)
    account
  end
end
