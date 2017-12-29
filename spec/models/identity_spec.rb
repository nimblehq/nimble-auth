require 'spec_helper'

RSpec.describe BuriAuth.configuration.resource_identity_class.constantize, type: :model do
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
    it { should validate_presence_of(:user) }
  end

  describe '.find_with_oauth' do
    it 'finds an identity when the params match' do
      actual_identity = Fabricate(:identity)
      received_identity = Identity.find_with_oauth(uid: actual_identity.uid, provider: actual_identity.provider)
      expect(received_identity).to eq(actual_identity)
    end

    it 'returns nil when the params dont match' do
      actual_identity = Fabricate.to_params(:identity)
      received_identity = Identity.find_with_oauth(uid: actual_identity[:uid], provider: actual_identity[:provider])
      expect(received_identity).to eq(nil)
    end
  end

  describe '.create_for' do
    it 'creates a new identity' do
      oauth_info = Fabricate.to_params(:identity).merge(credentials: { token: SecureRandom.urlsafe_base64 })

      expect { Identity.create_for(oauth_info, Fabricate(:user)) }.to change(Identity, :count).by(1)
    end
  end
end
