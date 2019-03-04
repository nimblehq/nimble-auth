require 'devise'
require 'omniauth-facebook'
require 'omniauth-google-oauth2'
require 'sass-rails'
require 'normalize-rails'
require_relative '../nimble_auth'

module NimbleAuth
  class Engine < ::Rails::Engine
    isolate_namespace NimbleAuth

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :fabrication, dir: 'spec/fabricators'
      g.assets false
      g.helper false
    end

    # Extend models in the main app safely
    config.to_prepare do
      NimbleAuth::Resource.extend_user_model
      NimbleAuth::Resource.extend_identity_model
    end

    config.after_initialize do
      if NimbleAuth.configuration.omniauth_providers.any?
        NimbleAuth::Omniauth.configure_providers

        # FIXME: Due to the way omninauth updates routes, the user model needs to be extended from the engine routes
        # as config.to_prepare block is called after the routes are reloaded (affect dev and test environments)
        NimbleAuth::Engine.routes.prepend do
          NimbleAuth::Resource.extend_user_model
        end
      end
    end
  end
end
