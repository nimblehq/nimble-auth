module BuriAuth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      authenticate
    end

    private

    def authenticate
      # ...
    end
  end
end
