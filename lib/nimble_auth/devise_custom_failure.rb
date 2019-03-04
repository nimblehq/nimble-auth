require 'devise/failure_app'

module NimbleAuth
  class DeviseCustomFailure < Devise::FailureApp
    def respond
      http_auth? ? http_auth : redirect
    end
  end
end
