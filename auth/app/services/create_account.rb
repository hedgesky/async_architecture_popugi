class CreateAccount
  def self.call(attributes:)
    account = Account.new(attributes)

    if account.save
      EventProducer.account_created(account)
      [true, account]
    else
      [false, account]
    end
  end
end
