require 'devise/failure_app'

module BuriAuth
  class DeviseCustomFailure < Devise::FailureApp
    def respond
      http_auth? ? http_auth : redirect
    end
  end
end
