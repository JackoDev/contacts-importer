Rails.application.routes.draw do
  resources :contacts do
    collection { post :import }
  end
  devise_for :users
  root to: 'home#index'
end
