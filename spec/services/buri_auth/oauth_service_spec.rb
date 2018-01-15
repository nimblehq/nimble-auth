require 'spec_helper'

RSpec.describe BuriAuth::OauthService, type: :service do
  describe '#perform' do
    context 'Valid Params' do
      it 'creates a user' do
        service = described_class.new(oauth_facebook_response)

        expect { service.perform }.to change(User, :count).by(1)
      end

      it 'creates an identity for the user' do
        service = described_class.new(oauth_facebook_response)

        expect { service.perform }.to change(Identity, :count).by(1)
      end
    end

    context 'Invalid Params' do
      context 'missing user details' do
        it 'raises error' do
          service = described_class.new({})
          expect { service.perform }.to raise_error(NoMethodError)
        end
      end
    end
  end

  private

  def oauth_facebook_response
    JSON.parse(File.read(File.expand_path('../../../fixtures/mock/facebook.json', __FILE__))).deep_symbolize_keys
  end
end
