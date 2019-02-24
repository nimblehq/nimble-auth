# Override the standard devise views by requiring 'devise' before the engine
require 'nimble_auth/engine'
require 'nimble_auth/omniauth_helper'
require 'nimble_auth/devise_setup'
require 'nimble_auth/user'
require 'nimble_auth/identity'

module NimbleAuth
  class Configuration
    # The model in the host application from which the engine User model is extended from
    # It defaults to simply 'User'
    # @return [String]
    attr_accessor :resource_class

    # The model in the host application from which the engine Identity model is extended from
    # It defaults to simply 'Identity'
    # @return [String]
    attr_accessor :resource_identity_class

    # List of supported Oauth Providers
    attr_accessor :omniauth_providers

    # Configuration for Facebook OAuth
    attr_accessor :facebook_app_id
    attr_accessor :facebook_app_secret

    # Configuration for Google OAuth
    attr_accessor :google_app_id
    attr_accessor :google_app_secret

    def initialize
      @resource_class = 'User'
      @resource_identity_class = 'Identity'
    end

    def valid?
      resource_class.present? && resource_identity_class.present?
    end

    private

    def resource_class_defined?
      Object.const_defined?("::#{resource_class}")
    end

    def resource_identity_class_defined?
      Object.const_defined?("::#{resource_identity_class}")
    end
  end

  class << self
    attr_accessor :configuration
  end

  module_function

  # TODO: Rename to configure
  def setup
    self.configuration = Configuration.new
    yield(configuration)

    after_setup
  end

  def after_setup
    return unless configuration.valid?

    extend_models
    setup_devise
  end

  def extend_models
    NimbleAuth::User.extend_model if NimbleAuth.configuration.resource_class.present?
    NimbleAuth::Identity.extend_model if NimbleAuth.configuration.resource_identity_class.present?
  end

  def setup_devise
    NimbleAuth::DeviseSetup.setup_with(configuration)
  end
end
