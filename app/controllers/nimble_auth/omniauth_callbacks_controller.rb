module NimbleAuth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    NimbleAuth.config.omniauth_providers.each do |provider|
      define_method provider do
        authenticate
      end
    end

    private

    def authenticate
      auth_service = AuthenticationService.new(request.env['omniauth.auth'])
      auth_response = auth_service.call

      if auth_response[:status] == :ok
        after_authentication_success(auth_response)
      else
        after_authentication_failure(auth_response)
      end
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def after_authentication_success(auth_response)
      # App logic goes here
      redirect_to root_path
    end

    def after_authentication_failure(auth_response)
      # App logic goes here
      redirect_to root_path
    end
    # rubocop:enable Lint/UnusedMethodArgument
  end
end
