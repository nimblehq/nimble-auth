# Override the standard devise views by requiring 'devise' before the engine
require 'buri_auth/engine'

module BuriAuth
  class Configuration
    # The model in the host application from which the engine User model is extended
    # It defaults to simply 'User'
    # @return [String]
    attr_accessor :resource_class
    attr_accessor :resource_identity_class
    attr_accessor :omniauth_providers
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
