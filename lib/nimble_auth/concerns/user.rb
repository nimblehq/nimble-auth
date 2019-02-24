module NimbleAuth
  module Concerns
    module User
      extend ActiveSupport::Concern

      included do
        has_many :identities, dependent: :destroy

        validates :first_name, :last_name, :email, presence: true
        validates :email, uniqueness: true

        devise :database_authenticatable,
               :registerable,
               :recoverable,
               :rememberable,
               :confirmable,
               :omniauthable,
               omniauth_providers: NimbleAuth.configuration.omniauth_providers

        def self.with_oauth(oauth)
          find_by(email: oauth[:info]['email'])
        end
      end
    end
  end
end
