BuriAuth::Engine.routes.draw do
  CUSTOM_CONTROLLERS = {
    omniauth_callbacks: 'buri_auth/omniauth_callbacks'
  }.freeze

  CUSTOM_PATH = {
    sign_in: 'signin',
    sign_up: 'signup',
    sign_out: 'signout'
  }.freeze

  # ==> Mount Devise Engine
  devise_for :users,
             module: :devise,
             path: '/',
             class_name: BuriAuth.configuration.resource_class,
             controllers: CUSTOM_CONTROLLERS,
             path_names: CUSTOM_PATH
end
