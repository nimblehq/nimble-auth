module NimbleAuth
  module Omniauth
    module_function

    def configure_providers
      # Refresh the loaded routes with appended omninauth paths
      Rails.application.reload_routes!

      NimbleAuth.configuration.omniauth_providers.each do |provider|
        generate_omniauth_path_helpers(provider)
        append_omniauth_callback_path(provider)
      end
    end

    # Generates url helpers for oauth providers.
    # Adds the helpers to `Engine` helpers to make it accessible in other parts of the app.
    #
    # Helper Format: [:provider]_authorize_path
    #   Eg: facebook_authorize_path, instagram_authorize_path
    #
    def generate_omniauth_path_helpers(provider)
      NimbleAuth::Engine.helpers.module_eval do
        define_method "#{provider}_authorize_path" do |*arg|
          query_params = arg.first
          omniauth_provider_path = "#{OmniAuth.config.path_prefix}/#{provider}"

          return omniauth_provider_path.to_s if query_params.blank?

          "#{omniauth_provider_path}?#{query_params.to_query}"
        end
      end
    end

    # Appends the `callback_path` to oauth provider strategy.
    #   This is the path user will be redirected to upon successful login.
    #
    # Eg: for facebook,
    #   sets callback_path to match `user_facebook_omniauth_callback_path`
    #
    def append_omniauth_callback_path(provider)
      provider_path = "user_#{provider}_omniauth_callback_path"
      provider_strategy = devise_provider_strategy(provider)

      provider_strategy[:callback_path] = auth_url_helpers.send(provider_path)
    end

    def auth_url_helpers
      NimbleAuth::Engine.routes.url_helpers
    end

    def devise_provider_strategy(provider)
      Devise.omniauth_configs[provider].strategy
    end
  end
end
