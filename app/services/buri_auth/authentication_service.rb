module BuriAuth
  class AuthenticationService
    attr_reader :auth

    def initialize(auth)
      @auth = auth.deep_symbolize_keys
    end

    def call
      identity = Identity.includes(:user).find_with_oauth(auth)
      return signup_strategy(auth) if identity.nil?

      signin_strategy(identity, auth)
    end

    private

    def signin_strategy(identity, auth)
      identity.update(oauth_token: auth[:credentials][:token])

      respond_with(
        identity: identity.reload,
        token: identity.oauth_token,
        status: :ok
      )
    end

    def signup_strategy(auth)
      user = User.find_by(email: auth.dig(:info, :email))

      return new_provider_strategy(auth, user) if user.present?

      new_user_strategy(auth)
    end

    def new_provider_strategy(oauth, user)
      identity = Identity.create_for(oauth, user)

      respond_with(
        identity: identity,
        token: identity.oauth_token,
        message: I18n.t('frontend.authentication.notice.merged_account'),
        status: :ok
      )
    end

    def new_user_strategy(auth)
      oauth_info_service = Authentication::OauthInfoService.new(auth)
      oauth = oauth_info_service.call

      user = UserFactory.build!(UserFactory::OAUTH, oauth, invitation_token)

      if user.blank?
        return respond_with(
          message: I18n.t('frontend.authentication.notice.account_creation_error'),
          status: :error
        )
      end

      identity = Identity.find_by(user_id: user.id)
      respond_with(
        identity: identity,
        token: identity.oauth_token,
        message: I18n.t('frontend.authentication.notice.account_creation_success'),
        status: :ok
      )
    rescue RestClient::Exception => e
      respond_with(
        message: e.message,
        status: :error
      )
    end

    def respond_with(token:, status:, message: nil, identity: nil)
      {
        identity: identity,
        token: token,
        message: message,
        status: status
      }
    end
  end
end
