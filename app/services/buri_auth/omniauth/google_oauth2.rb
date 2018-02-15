# Extracts user_profile data from auth response
module BuriAuth
  module Omniauth
    class GoogleOauth2
      attr_reader :oauth

      def initialize(oauth)
        @oauth = oauth
      end

      def to_h
        {
          first_name: raw_info.dig(:first_name),
          last_name: raw_info.dig(:last_name),
          email: raw_info.dig(:email),
          avatar: raw_info.dig(:image)
        }
      end

      private

      def raw_info
        oauth.dig(:info)
      end
    end
  end
end
