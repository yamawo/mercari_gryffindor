Rails.application.routes.draw do
  root to: "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get "search_for", to: "application#search_for"
  get "select_search", to: "application#select_search"
  get "search_form_lv2", to: "application#search_form_lv2"

  resources :products do
    get "product_confirmation"
    post "product_pay"
    get "product_done"
    collection do
      get "category"
      get "category_list"
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

  resources :addresses, only: [:update]

  resources :users do
    collection do
      get "profile"
      get "mypage"
      get "confirmation"
      get "logout"
      get "card_registration"
      get "card_registration_form"
      post "card_registration_create"
      delete "card_delete"
      scope :sign_up do           # ディレクトリの階層の変更はなし
        get 'step3'
        get 'step4'
        get 'step6'
        get 'step7'
        post 'step8'
      end
    end
  end
  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'

  root 'products#index'
end
