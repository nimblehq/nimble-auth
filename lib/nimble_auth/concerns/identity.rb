module NimbleAuth
  module Concerns
    module Identity
      extend ActiveSupport::Concern

      included do
        belongs_to :user

        validates :uid, :provider, :oauth_token, presence: true

        class << self
          def create_for(oauth:, user:)
            create!(
              uid: oauth[:uid],
              provider: oauth[:provider],
              oauth_token: oauth.dig(:credentials, :token),
              user_id: user.id
            )
          end
        end
      end
    end
  end
end
