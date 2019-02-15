require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

require 'nimble_auth'

module Dummy
  class Applicatio

    n < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.eager_load = false

    config.autoload_paths += ["#{config.root}/app/"]
  end
end
