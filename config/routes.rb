Rails.application.routes.draw do
  root "courses#index"

  resources :courses do
    resources :chapters, shallow: true do
      resources :stages, shallow: true
    end
  end
end
