# TODO: Review if it's the best way to have devise error messages from Devise
# https://groups.google.com/forum/#!topic/plataformatec-devise/VhnVPh9sJCI
require_relative '../lib/nimble_auth/devise_custom_failure'

NimbleAuth::Engine.routes.draw do
  if NimbleAuth.configuration.resource_class.present?
    # ==> Mount Devise Engine
    devise_for NimbleAuth.configuration.resource_class.pluralize.downcase.to_sym,
               module: :devise,
               path: '/',
               class_name: NimbleAuth.configuration.resource_class,
               controllers: {
                 omniauth_callbacks: 'nimble_auth/omniauth_callbacks',
                 sessions: 'nimble_auth/sessions'
               },
               path_names: {
                 sign_in: 'signin',
                 sign_up: 'signup',
                 sign_out: 'signout'
               }

    devise_scope :user do
      get '/signout', to: 'sessions#destroy', as: :user_logout
    end
  end
end
