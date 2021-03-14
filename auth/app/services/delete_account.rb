class DeleteAccount
  def self.call(account:)
    account.destroy
    EventProducer.account_deleted(account)
    true
  end
end
