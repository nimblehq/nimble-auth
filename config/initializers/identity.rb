Rails.application.configure do
  config.after_initialize do

    # Extend the parent Model class
    BuriAuth.configuration.resource_identity_class.constantize.class_eval do
      belongs_to :user

      validates :uid, :provider, :user, presence: true

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
