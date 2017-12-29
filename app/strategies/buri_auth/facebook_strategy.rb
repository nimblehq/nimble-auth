module BuriAuth
  class FacebookStrategy
    attr_accessor :oauth

    def initialize(oauth_params)
      @oauth = oauth_params
    end

    def perform
      binding.pry
    end
  end
end
