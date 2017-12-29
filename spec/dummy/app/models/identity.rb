class Identity < ApplicationRecord
  belongs_to :user

  validates :uid, :provider, :oauth_token, presence: true
end
