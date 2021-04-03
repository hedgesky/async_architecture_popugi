return if defined?(Rails::Console) || Rails.env.test?

# ACCOUNTS_CONSUMER = Consumers::AccountsCud.new.subscribe
# ACCOUNTING_CONSUMER = Consumers::AccountingBe.new.subscribe
