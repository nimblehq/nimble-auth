module NimbleAuth
  module OmniauthHelper
    module_function

    # Add extra configurations to omniauth providers
    def configure_omniauth_provider(provider)
      generate_omniauth_url_helpers(provider)
      append_omniauth_callback_path(provider)
    end

    # Generates url helpers for oauth providers.
    # Adds the helpers to `Engine` helpers to make it accessible in other parts of app.
    #
    # Helper Format: [:provider]_authorize_path
    #   Eg: facebook_authorize_path, instagram_authorize_path
    #
    def generate_omniauth_url_helpers(provider)
      NimbleAuth::Engine.helpers.module_eval do
        define_method "#{provider}_authorize_path" do |*arg|
          query_params = arg.first

          return "#{OmniAuth.config.path_prefix}/#{provider}" if query_params.blank?

          "#{OmniAuth.config.path_prefix}/#{provider}?#{query_params.to_query}"
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
