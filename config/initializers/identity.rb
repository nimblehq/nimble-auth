Rails.application.configure do
  config.after_initialize do

    # Extend the parent Model class
    BuriAuth.configuration.resource_identity_class.constantize.class_eval do
      validates :uid, :provider, presence: true

      belongs_to :user

      class << self
        def find_with_oauth(oauth)
          find_by(uid: oauth[:uid], provider: oauth[:provider])
        end

        def create_with_oauth(oauth)
          create!(
            uid: oauth[:uid],
            provider: oauth[:provider],
            oauth_token: oauth.dig(:credentials, :token)
          )
        end

        def create_for(oauth, user)
          identity = create_with_oauth(oauth)
          identity.update!(user: user)
          identity
        end
      end
    end
  end
end
