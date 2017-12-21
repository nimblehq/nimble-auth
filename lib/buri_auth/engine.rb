module BuriAuth
  class Engine < ::Rails::Engine
    isolate_namespace BuriAuth

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :fabrication, dir: 'spec/fabricators'
      g.assets false
      g.helper false
    end
  end
end
