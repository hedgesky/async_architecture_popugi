return if defined?(Rails::Console) || Rails.env.test?

s = Rufus::Scheduler.singleton
accounts_consumer = AccountsCudConsumer.new
tasks_consumer = TasksBeConsumer.new

s.every '5s' do
  accounts_consumer.sync
  tasks_consumer.sync
end
