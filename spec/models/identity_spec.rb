require 'spec_helper'

RSpec.describe NimbleAuth.configuration.resource_identity_class.constantize, type: :model do
  describe 'db columns' do
    ## Attributes
    it { should have_db_column(:uid).of_type(:string) }
    it { should have_db_column(:provider).of_type(:string) }
    it { should have_db_column(:oauth_token).of_type(:string) }
    it { should have_db_column(:oauth_secret).of_type(:string) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:oauth_token) }
  end

  describe '.create_for' do
    it 'creates a new identity' do
      oauth_info = Fabricate.to_params(:identity).merge(credentials: { token: SecureRandom.urlsafe_base64 })

      expect { described_class.create_for(oauth: oauth_info, user: Fabricate(:user)) }.to change(Identity, :count).by(1)
    end
  end
end
