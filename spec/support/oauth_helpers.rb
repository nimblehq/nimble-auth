# module OAuthHelpers
#   def mock_oauth_for(provider)
#     OmniAuth.config.test_mode = true
#
#     add_mock(provider, JSON.parse(File.read(mock_file_path(provider))))
#
#     auth_info = OmniAuth.config.mock_auth[provider]
#
#     Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
#     Rails.application.env_config['omniauth.auth'] = auth_info
#   end
#
#   def mock_file_path(provider)
#     File.expand_path("../fixtures/mock/#{provider}.json", __FILE__)
#   end
#
#   def add_mock(provider, response)
#     OmniAuth.config.add_mock(provider.to_sym, response)
#   end
# end
#
# RSpec.configure do |config|
#   config.include OAuthHelpers
# end
