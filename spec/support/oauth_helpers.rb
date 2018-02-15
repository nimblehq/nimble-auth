module OauthHelpers
  module OAuthHelpers
    def omniauth_facebook_response
      response_json = File.read('spec/fixtures/mock/omniauth-facebook.json')

      JSON.parse(response_json).deep_symbolize_keys
    end
  end
end

RSpec.configure do |config|
  config.include OauthHelpers::OAuthHelpers
end
