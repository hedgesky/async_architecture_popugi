class DeleteAccount
  def self.call(account:)
    account.destroy
    Producers::AccountsCud.account_deleted(account)
    true
  end
end
