Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  mount ShrineImageUploader.derivation_endpoint =>
    Rails.application.config_for(:shrine)[:derivation_endpoint]

  # Defines the root path route ("/")
  # root "articles#index"
end
