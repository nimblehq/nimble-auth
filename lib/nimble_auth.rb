# Override the standard devise views by requiring 'devise' before the engine
require 'nimble_auth/engine'
require 'nimble_auth/omniauth_helper'
require 'nimble_auth/devise_setup'
require 'nimble_auth/user'
require 'nimble_auth/identity'

module NimbleAuth
  class Configuration
    attr_accessor :resource_class
    attr_accessor :resource_identity_class
    attr_accessor :omniauth_providers
    attr_accessor :facebook_app_id
    attr_accessor :facebook_app_secret
    attr_accessor :google_app_id
    attr_accessor :google_app_secret

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
    attr_accessor :config
  end

  module_function

  def configuration
    @config ||= Configuration.new
  end

  def setup
    yield(configuration)

    after_setup
  end

  def after_setup
    return unless config.valid?

    extend_models
    setup_devise
  end

  def setup_devise
    NimbleAuth::DeviseSetup.setup_with(configuration)
  end

  def extend_models
    NimbleAuth::User.extend_model if NimbleAuth.configuration.resource_class.present?
    NimbleAuth::Identity.extend_model if NimbleAuth.configuration.resource_identity_class.present?
  end
end
