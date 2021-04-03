class CreateAccount
  def self.call(attributes:)
    account = Account.new(attributes)

    if account.save
      Producers::AccountsCud.account_created(account)
      [true, account]
    else
      [false, account]
    end
  end
end
