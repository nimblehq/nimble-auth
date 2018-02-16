Rails.application.configure do
  config.after_initialize do
    # Extend the parent Model class
    BuriAuth.configuration.resource_class.constantize.class_eval do
      has_many :identities, dependent: :destroy

      validates :first_name, :last_name, :email, presence: true
      validates :email, uniqueness: true

      devise :database_authenticatable,
             :registerable,
             :recoverable,
             :rememberable,
             :confirmable,
             :omniauthable,
             omniauth_providers: BuriAuth.config.omniauth_providers

      def self.with_oauth(oauth)
        find_by(email: oauth[:info]['email'])
      end
    end
  end
end
