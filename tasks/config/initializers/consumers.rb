return if defined?(Rails::Console) || Rails.env.test?

ACCOUNTS_CONSUMER = Consumers::AccountsCud.new.subscribe
TASKS_CONSUMER = Consumers::TasksBe.new.subscribe
