Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
end
