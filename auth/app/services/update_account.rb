class UpdateAccount
  def self.call(account:, attributes:)
    if account.update(attributes)
      Producers::AccountsCud.account_updated(account)
      true
    else
      false
    end
  end
end
