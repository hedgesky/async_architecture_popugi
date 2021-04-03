return if defined?(Rails::Console) || Rails.env.test?

TASKS_CONSUMER = Consumers::TasksBe.new.subscribe
ACCOUNTS_CONSUMER = Consumers::AccountsCud.new.subscribe
