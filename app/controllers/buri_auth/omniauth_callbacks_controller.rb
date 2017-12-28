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
      BuriAuth::OauthStrategy.perform(request.env['omniauth.auth'])
    end
  end
end
