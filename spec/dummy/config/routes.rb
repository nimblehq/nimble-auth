Rails.application.routes.draw do
  mount NimbleAuth::Engine, at: '/auth'
end
