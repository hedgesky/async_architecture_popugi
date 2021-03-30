OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :beak, ENV['ACCOUNTING_APP_KEY'], ENV['ACCOUNTING_APP_SECRET_KEY']
end