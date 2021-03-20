OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :beak, ENV['TASKS_APP_KEY'], ENV['TASKS_APP_SECRET_KEY']
end