require 'spec_helper'

RSpec.describe BuriAuth::OmniauthCallbacksController, type: :controller do
  include Devise::Test::ControllerHelpers
  routes { BuriAuth::Engine.routes }

  describe 'POST #facebook' do
    context 'signup', vcr: 'oauth/facebook' do
      it 'creates a new user' do
        mock_oauth_for('facebook')

        post :facebook

        # Implement expectations here ...
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
