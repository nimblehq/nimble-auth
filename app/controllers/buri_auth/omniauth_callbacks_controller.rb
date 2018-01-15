module BuriAuth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    SUPPORTED_PROVIDERS = %i[facebook].freeze

    SUPPORTED_PROVIDERS.each do |provider|
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

    def after_authentication_success(auth_response)
      # App logic goes here
    end

    def after_authentication_failure(auth_response)
      # App logic goes here
    end
  end
end
