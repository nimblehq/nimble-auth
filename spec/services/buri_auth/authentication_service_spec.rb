require 'spec_helper'

RSpec.describe BuriAuth::AuthenticationService, type: :service do
  describe '#call' do
    context 'new user' do
      context 'Valid params' do
        it 'creates a new user' do
          service = described_class.new(oauth_facebook_response)

          expect { service.call }.to change(User, :count).by(1)
        end

        it 'creates a new identity for the user' do
          service = described_class.new(oauth_facebook_response)

          expect { service.call }.to change(Identity, :count).by(1)
          expect(Identity.last.oauth_token).to eq(oauth_facebook_response['credentials']['token'])
        end

        it 'responds with status :ok' do
          service = described_class.new(oauth_facebook_response)
          response = service.call

          expect(response[:status]).to eq(:ok)
        end
      end

      context 'Invalid params' do
        it 'creates a new user' do
          service = described_class.new(oauth_facebook_response)

          expect { service.call }.to change(User, :count).by(1)
        end
      end
    end
  end

  private

  def oauth_facebook_response
    JSON.parse(File.read(File.expand_path('../../../fixtures/mock/facebook.json', __FILE__)))
  end
end
