require 'spec_helper'

RSpec.describe BuriAuth::OmniauthAuthenticationService, type: :service do
  describe '#call' do
    context 'new user' do
      context 'Valid params' do
        context 'Facebook' do
          it 'creates a user' do
            service = described_class.new(omniauth_facebook_response)

            expect { service.call }.to change(User, :count).by(1)
          end

          it 'creates an identity for the user' do
            service = described_class.new(omniauth_facebook_response)

            expect { service.call }.to change(Identity, :count).by(1)
          end

          it 'responds with success response' do
            service = described_class.new(omniauth_facebook_response)
            response = service.call

            expect(response[:status]).to eq(:ok)
            expect(response[:message]).to eq(I18n.t('activerecord.notices.models.user.create'))
          end
        end
      end

      context 'Invalid params' do
        context 'Facebook' do
          it 'responds with error message' do
            oauth_response = omniauth_facebook_response
            oauth_response[:extra] = nil

            service = described_class.new(oauth_response)
            response = service.call

            expect(response[:status]).to eq(:error)
            expect(response[:message]).to be_present
          end
        end
      end
    end

    context 'existing user with same oauth creds' do
      context 'Facebook' do
        it 'does not create a new user' do
          user = Fabricate(:user, email: 'joe@bloggs.com')
          Fabricate(:identity, user_id: user.id, provider: 'facebook', uid: '1461189797258916')

          authentication_service = described_class.new(omniauth_facebook_response)

          expect { authentication_service.call }.to change(User, :count).by(0)
        end

        it 'does not create a new identity' do
          user = Fabricate(:user, email: 'joe@bloggs.com')
          Fabricate(:identity, user_id: user.id, provider: 'facebook', uid: '1461189797258916')

          authentication_service = described_class.new(omniauth_facebook_response)

          expect { authentication_service.call }.to change(Identity, :count).by(0)
        end

        it 'responds with success response' do
          user = Fabricate(:user, email: 'joe@bloggs.com')
          Fabricate(:identity, user_id: user.id, provider: 'facebook', uid: '1461189797258916')

          authentication_service = described_class.new(omniauth_facebook_response)
          response = authentication_service.call

          expect(response[:status]).to eq(:ok)
        end
      end
    end
  end
end
