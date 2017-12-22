Rails.application.routes.draw do
  mount BuriAuth::Engine => '/'
end
