require_relative 'concerns/user'
require_relative 'concerns/identity'

module NimbleAuth
  module Resource
    module_function

    # Extend the main app model User class
    def extend_user_model
      NimbleAuth.configuration.resource_class.constantize.send(:include, NimbleAuth::Concerns::User)
    end

    # Extend the main app model Identity class
    def extend_identity_model
      NimbleAuth.configuration.resource_identity_class.constantize.send(:include, NimbleAuth::Concerns::Identity)
    end
  end
end
