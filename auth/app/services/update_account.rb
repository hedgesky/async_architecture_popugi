class UpdateAccount
  def self.call(account:, attributes:)
    if account.update(attributes)
      EventProducer.account_updated(account)
      true
    else
      false
    end
  end
end
