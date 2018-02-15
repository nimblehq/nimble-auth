require 'spec_helper'

RSpec.describe BuriAuth.configuration.resource_class.constantize, type: :model do
  describe 'db columns' do
    ## Attributes
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:avatar).of_type(:text) }

    ## Database authenticatable
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }

    ## Confirmable
    it { should have_db_column(:confirmation_token).of_type(:string) }
    it { should have_db_column(:confirmed_at).of_type(:datetime) }
    it { should have_db_column(:confirmation_sent_at).of_type(:datetime) }

    ## Recoverable
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }

    ## Rememberable
    it { should have_db_column(:remember_created_at).of_type(:datetime) }

    ## Trackable
    it { should have_db_column(:sign_in_count).of_type(:integer) }
    it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
  end

  describe 'associations' do
    it { should have_many(:identities) }
  end

  describe '.with_oauth' do
    context 'with valid oauth params' do
      it 'fetches the user' do
        email = FFaker::Internet.email
        user = Fabricate(:user, email: email)
        oauth_params = {
          info: {
            'email' => email
          }
        }
        response = described_class.with_oauth(oauth_params)
        expect(response).to eq(user)
      end
    end

    context 'with invalid oauth params' do
      it 'returns nil' do
        oauth_params = {
          info: {
            'email' => FFaker::Internet.email
          }
        }
        response = described_class.with_oauth(oauth_params)
        expect(response).to eq(nil)
      end
    end
  end
end
