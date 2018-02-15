# Extracts user_profile data from auth response
module BuriAuth
  module Omniauth
    class Facebook
      attr_reader :oauth

      def initialize(oauth)
        @oauth = oauth
      end

      def to_h
        {
          first_name: raw_info.dig(:first_name),
          last_name: raw_info.dig(:last_name),
          email: raw_info.dig(:email),
          username: raw_info.dig(:username),
          location: raw_info.dig(:location, :name),
          avatar: oauth.dig(:info, :image)
        }
      end

      private

      def raw_info
        oauth.dig(:extra, :raw_info) || {}
      end
    end
  end
end
