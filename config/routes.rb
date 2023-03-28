Rails.application.routes.draw do
  devise_for :users
  root 'courses#index'

  resources :courses do
    resources :chapters, shallow: true do
      resources :stages, shallow: true
    end
  end
end
