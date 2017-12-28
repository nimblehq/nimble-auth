BuriAuth::Engine.routes.draw do
  devise_for :users,
             class_name: BuriAuth.configuration.resource_class,
             module: :devise,
             path: 'auth',
             path_names: {
               sign_in: 'signin',
               sign_up: 'signup',
               sign_out: 'signout'
             }
end
