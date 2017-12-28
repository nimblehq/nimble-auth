module BuriAuth
  class FacebookStrategy
    attr_accessor :oauth

    def initialize(oauth_params)
      @oauth = oauth_params
    end

    def perform
      # implement Strategy here ...
    end
  end
end
