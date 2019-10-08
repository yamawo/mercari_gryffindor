Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users
  resources :products, only: [:index]
  resources :users do
    collection do
      scope :sign_up do           # ディレクトリの階層の変更はなし
        get 'step3'
        get 'step4'
        get 'step5'
        get 'step6'
        get 'step7'
        get 'step8'
      end
    end
  end
end
