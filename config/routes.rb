Rails.application.routes.draw do
  root to: "products#index"
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:new, :create, :index] do
    collection do
      get "create_category_children"
      get 'privacy_policy'
      get "create_category_grandchildren"
      get "search_size"
      get "search"
    end
  end

  resources :address 

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } 

  
  
  
  
  
  
  
  
  resources :products, only: [:index, :show]
      
  resources :users do
    collection do
      get "profile"
      get "mypage"
      get "confirmation"
      get "logout"
      get "card_registration"
      scope :sign_up do           # ディレクトリの階層の変更はなし
        get 'step3'
        get 'step4'
        get 'step6'
        get 'step7'
        post 'step8'
      end
    end
  end
  
  # post "likes/:product_id/create", to: "likes#create", constraints: {product_id: /\d+/}, as: :likes_create
  # post "likes/:product_id/delete", to: "likes#delete", constraints: {product_id: /\d+/}, as: :likes_delete
end
