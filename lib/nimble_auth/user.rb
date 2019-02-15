module NimbleAuth
  module User
    module_function

    def extend_model
      # Extend the parent Model class
      NimbleAuth.configuration.resource_class.constantize.class_eval do
        has_many :identities, dependent: :destroy

        validates :email, presence: true
        validates :email, uniqueness: true

        devise :database_authenticatable,
               :registerable,
               :recoverable,
               :rememberable,
               :confirmable,
               :omniauthable,
               omniauth_providers: NimbleAuth.config.omniauth_providers

        def self.with_oauth(oauth)
          find_by(email: oauth[:info]['email'])
        end
      end
    end
  end
end
