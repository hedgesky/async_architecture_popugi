OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :beak, ENV['ANALYTICS_APP_KEY'], ENV['ANALYTICS_APP_SECRET_KEY']
end