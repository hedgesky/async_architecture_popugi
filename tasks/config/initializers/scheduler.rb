return if defined?(Rails::Console) || Rails.env.test?

s = Rufus::Scheduler.singleton
accounts_streamer = AccountsStreamer.new

s.every '5s' do
  Rails.logger.debug "Syncing accounts..."
  accounts_streamer.sync
end
