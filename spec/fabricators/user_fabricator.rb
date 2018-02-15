Fabricator(:user) do
  first_name { FFaker::Name.first_name }
  last_name { FFaker::Name.last_name }
  email { sequence(:email) { |i| "dev#{i}@nimbl3.com" } }
  password '12345678'
  confirmed_at { Time.zone.now }
  username { [FFaker::Internet.user_name, Time.now.to_i].join }
end

Fabricator(:oauth_user_signup, class_name: 'Hash') do
  provider { %w[facebook google_oauth2].sample }
  uid { SecureRandom.uuid }
  credentials do
    { token: SecureRandom.hex(32) }
  end
  info do
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      email: FFaker::Internet.email,
      image: FFaker::Internet.http_url,
      birthday: FFaker::Time.date
    }
  end
end
