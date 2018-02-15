BuriAuth.setup do |config|
  config.resource_class = 'User'
  config.resource_identity_class = 'Identity'
  config.omniauth_providers = %i[facebook].freeze
end
