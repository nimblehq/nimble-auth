BuriAuth.setup do |config|
  config.resource_class = 'User'
  config.resource_identity_class = 'Identity'
  config.omniauth_providers = %i[facebook google_oauth2].freeze
  config.facebook_app_id = "19312345674803053449100"
  config.facebook_app_secret = "81b12345d21a5cbba7b0da39a03792b3fa858"
  config.google_app_id = "2320364512345677326-n1qhbva17sua1q727jnb99prvo5inie1.apps.googleusercontent.com"
  config.google_app_secret = "Lp6oWqwertyuiGjNSn9EPOU0QWCYpmj_"
end
