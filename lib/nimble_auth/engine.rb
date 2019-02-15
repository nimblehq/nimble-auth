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

    initializer 'nimble_auth.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper NimbleAuth::Engine.helpers
      end
    end
  end
end
