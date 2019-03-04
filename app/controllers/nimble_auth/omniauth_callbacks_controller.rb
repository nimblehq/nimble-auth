module NimbleAuth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :check_authentication_status

    NimbleAuth.config.omniauth_providers.each do |provider|
      define_method provider do
        authenticate
      end
    end

    private

    def authenticate
      auth_service = AuthenticationService.new(auth_params: auth_params, auth_type: 'omniauth')
      auth_response = auth_service.call

      if auth_response[:status] == :ok
        after_authentication_success(auth_response)
      else
        after_authentication_failure(auth_response)
      end
    end

    def auth_params
      request.env['omniauth.auth']
    end

    def after_authentication_success(auth_response)
      user = auth_response[:identity].user

      sign_in(user)

      redirect_to after_sign_in_redirect_path(user)
    end

    def after_authentication_failure(auth_response)
      flash[:error] = auth_response[:message]

      redirect_to new_user_session_path
    end

    def check_authentication_status
      return true if request.env['omniauth.error'].blank?

      humanized_error_messages = error_message.transform_values(&:humanize)

      flash[:error] = I18n.t(
        'activerecord.errors.messages.omniauth.authentication_failure',
        title: humanized_error_messages[:title],
        description: humanized_error_messages[:description],
        reason: humanized_error_messages[:reason]
      )

      redirect_to new_user_session_path
    end

    def error_message
      {
        title: params[:error] || '',
        description: params[:error_description] || '',
        reason: params[:error_reason] || ''
      }
    end
  end
end
