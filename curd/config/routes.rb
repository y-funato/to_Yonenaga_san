Rails.application.routes.draw do
  resources :companies do
    resources :groups do
      resources :users do
        resources :name_cards
      end
    end
  end
end
