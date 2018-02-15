# Override the standard devise views by requiring 'devise' before the engine
require 'buri_auth/engine'

module BuriAuth
  class Configuration
    attr_accessor :resource_class
    attr_accessor :resource_identity_class
    attr_accessor :omniauth_providers
    attr_accessor :facebook_app_id
    attr_accessor :facebook_app_secret
  end

  class << self
    attr_accessor :config
  end

  module_function

  def configuration
    @config ||= Configuration.new
  end

  def setup
    yield(configuration)
  end
end
