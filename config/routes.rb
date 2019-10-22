Rails.application.routes.draw do
  root to: "products#index"
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:new, :create, :index, :edit, :update, :show] do
    collection do
      get "create_category_children"
      get 'privacy_policy'
      get "create_category_grandchildren"
      get "search_size"
      get "search"
      get "selling_stage"
      get "selling_stage2"
      get "selling_stage3"
    end
  end

  resources :address 

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } 

  
  
  
  
  
  
  
  
  
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
end
