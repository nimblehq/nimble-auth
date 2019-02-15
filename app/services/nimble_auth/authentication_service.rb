require 'nimble_auth/omniauth_authentication_service'

module NimbleAuth
  class AuthenticationService
    attr_reader :auth_params, :auth_type

    def initialize(auth_params: {}, auth_type: nil)
      @auth_params = auth_params.deep_symbolize_keys
      @auth_type = auth_type
    end

    def call
      auth_klass.new(auth_params).call
    end

    private

    def auth_klass
      "NimbleAuth::#{auth_type.titleize}AuthenticationService".constantize
    end
  end
end
