# Override the standard devise views by requiring 'devise' before the engine
require 'buri_auth/engine'
require 'buri_auth/omniauth_helper'
require 'buri_auth/devise_setup'
require 'buri_auth/user'
require 'buri_auth/identity'

module BuriAuth
  class Configuration
    attr_accessor :resource_class
    attr_accessor :resource_identity_class
    attr_accessor :omniauth_providers
    attr_accessor :facebook_app_id
    attr_accessor :facebook_app_secret
    attr_accessor :google_app_id
    attr_accessor :google_app_secret
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
    extend_models
    setup_devise
  end

  def setup_devise
    BuriAuth::DeviseSetup.setup_with(configuration)
  end

  def extend_models
    BuriAuth::User.extend_model
    BuriAuth::Identity.extend_model
  end
end
