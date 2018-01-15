module BuriAuth
  class OauthService
    attr_accessor :oauth, :user, :identity

    def initialize(oauth_params)
      @oauth = oauth_params
    end

    def perform
      create_user
      create_identity
    end

    private

    def create_user
      profile_details = oauth[:extra][:raw_info]

      @user = User.create!(
        first_name: profile_details[:first_name],
        last_name: profile_details[:last_name],
        email: profile_details[:email],
        username: profile_details[:username],
        avatar: oauth[:info][:image],
        confirmed_at: Time.zone.now
      )
    end

    def create_identity
      @identity = Identity.create_for(oauth, user)
    end
  end
end
