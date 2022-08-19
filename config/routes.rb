Rails.application.routes.draw do
  get 'auth/index'
  get 'auth/login'
  get 'auth/logout'
  ActiveAdmin.routes(self)

  mount ShrineImageUploader.derivation_endpoint =>
    Rails.application.config_for(:shrine)[:derivation_endpoint]

  get '/admin/login', to: 'auth#index'
  post '/admin/login', to: 'auth#login'
  get '/admin/logout', to: 'auth#logout'

  root to: redirect('/admin/login')
end
