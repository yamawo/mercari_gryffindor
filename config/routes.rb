Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } 
  
  resources :address 
  
  resources :credits, only: [:new, :show] do
    collection do
      post 'show', to: 'credits#show'
      post 'pay', to: 'credits#pay'
      post 'delete', to: 'credits#delete'
    end
  end
  
  resources :products, only: [:index] do
    collection do
      get 'privacy_policy'
    end
  end  
  
  resources :users do
    collection do
      scope :sign_up do           # ディレクトリの階層の変更はなし
        get 'step3'
        get 'step4'
        get 'step6'
        get 'step7'
        post 'step8'
      end
    end
  end

  resources :users, only: [:mypage, :logout] do
    collection do
      get "profile"
      get "mypage"
      get "confirmation"
      get "logout"
    end
  end
end
