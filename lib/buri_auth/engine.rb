require 'devise'
require 'omniauth-facebook'
require_relative '../buri_auth'

module BuriAuth
  class Engine < ::Rails::Engine
    isolate_namespace BuriAuth

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :fabrication, dir: 'spec/fabricators'
      g.assets false
      g.helper false
    end

    initializer 'buri_auth.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper BuriAuth::Engine.helpers
      end
    end

    def self.mounted_path
      Rails.application.routes.routes.detect { |route| route.app&.app == self }&.path
    end
  end
end
