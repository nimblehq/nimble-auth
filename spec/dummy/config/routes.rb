Rails.application.routes.draw do
  mount BuriAuth::Engine, at: '/auth'
end
