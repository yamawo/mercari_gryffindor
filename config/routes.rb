Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:new, :create] do
    collection do
      get "create_category_children"
      get 'privacy_policy'
      get "create_category_grandchildren"
      get "search_size"
      get "search"
    end
  end

  resources :users do
    collection do
      get "profile"
      get "mypage"
      get "logout"
    end
  end
end