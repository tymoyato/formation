Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'dashboard', to: 'home#dashboard'
  end

  resources :contributions
  resources :projects
    mount Shrine.upload_endpoint(:cache) => "/upload"
end
