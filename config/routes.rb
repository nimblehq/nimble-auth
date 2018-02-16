require 'buri_auth/user'
require 'buri_auth/identity'

BuriAuth::Engine.routes.draw do
  CUSTOM_CONTROLLERS = {
    omniauth_callbacks: 'buri_auth/omniauth_callbacks',
    sessions: 'buri_auth/sessions'
  }.freeze

  CUSTOM_PATH = {
    sign_in: 'signin',
    sign_up: 'signup',
    sign_out: 'signout'
  }.freeze

  # BuriAuth::User.extend_model
  # BuriAuth::Identity.extend_model

  # ==> Mount Devise Engine
  devise_for :users,
             module: :devise,
             path: '/',
             class_name: BuriAuth.configuration.resource_class,
             controllers: CUSTOM_CONTROLLERS,
             path_names: CUSTOM_PATH
end
