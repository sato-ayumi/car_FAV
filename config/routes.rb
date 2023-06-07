Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    root 'homes#top'
  end
   
      # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get "about" => "homes#about", as: "about"
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw_user'
    resources :users, only: [:show, :edit, :update]
    resources :reviews
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
