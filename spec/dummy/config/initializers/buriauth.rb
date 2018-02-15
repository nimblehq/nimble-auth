BuriAuth.setup do |config|
  config.resource_class = 'User'
  config.resource_identity_class = 'Identity'
  config.omniauth_providers = %i[facebook].freeze
  config.facebook_app_id = ENV['FACEBOOK_APP_ID']
  config.facebook_app_secret = ENV['FACEBOOK_APP_SECRET']
end
