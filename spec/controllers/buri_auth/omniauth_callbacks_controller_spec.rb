require 'spec_helper'

RSpec.describe BuriAuth::OmniauthCallbacksController, type: :controller do
  routes { BuriAuth::Engine.routes }

  describe 'POST #facebook' do
    context 'Valid Request', vcr: 'oauth/facebook' do
      it 'renders the index template' do
        mock_oauth_for('facebook')

        post :facebook

        expect(response).to render_template(:index)
      end

      it 'signs in the user' do
        mock_oauth_for('facebook')

        post :facebook

        expect(subject.current_user).to be_present
      end
    end

    context 'Invalid Request', vcr: 'oauth/facebook' do
      it 'renders the index template' do
        # ...
      end
    end
  end

  private

  def mock_oauth_for(provider)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(provider.to_sym, JSON.parse(File.read(mock_file_path(provider))))

    mock_request_env(provider)
  end

  def mock_request_env(provider)
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider.to_sym]
  end

  def mock_file_path(provider)
    File.expand_path("../../../fixtures/mock/#{provider}.json", __FILE__)
  end
end
