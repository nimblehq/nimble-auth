require_relative 'facebook_strategy'

module BuriAuth
  class OauthStrategy
    STRATEGIES = {
      facebook: FacebookStrategy
    }.freeze

    def self.perform(oauth_params)
      provider = oauth_params['provider'].to_sym

      STRATEGIES[provider]
        .new(oauth_params)
        .perform
    end
  end
end
