Rails.application.routes.draw do
  mount BuriAuth::Engine => "/buri_auth"
end
