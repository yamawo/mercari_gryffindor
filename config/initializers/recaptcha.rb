Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials[:RECAPTCHA_SITE_KEY]
  config.secret_key = Rails.application.credentials[:RECAPTCHA_SECRET_KEY]
end