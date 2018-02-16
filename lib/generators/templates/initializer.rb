BuriAuth.setup do |config|
  config.resource_class = 'User'
  config.resource_identity_class = 'Identity'
  config.omniauth_providers = %i[facebook google_oauth2].freeze
  config.facebook_app_id = "facebook_app_id"
  config.facebook_app_secret = "facebook_app_secret"
  config.google_app_id = "google_app_id"
  config.google_app_secret = "google_app_secret"
end
