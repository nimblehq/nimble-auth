Fabricator(:identity) do
  provider 'facebook'
  uid { SecureRandom.urlsafe_base64 }
  oauth_token { SecureRandom.urlsafe_base64 }
  user { Fabricate(:user) }
end
