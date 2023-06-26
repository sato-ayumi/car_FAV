Rails.application.routes.draw do

  get "/search", to: "searches#search",  as: "search"

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root "homes#top"
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :reports, only: [:show, :update, :destroy]
  end

  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

   devise_scope :user do
    post 'guests/sign_in', to: 'users/sessions#guest_sign_in', as: "guest_sign_in"
  end

  scope module: :public do
    root "homes#top"
    get "about" => "homes#about", as: "about"
    get "users/:id/unsubscribe", to: "users#unsubscribe", as: "unsubscribe"
    patch "users/:id/withdraw", to: "users#withdraw", as: "withdraw_user"
    
    resources :users, only: [:show, :edit, :update]
    resources :reviews do
      resources :reports, only: [:create]
      resources :comments, only: [:create, :destroy]
      collection do
        get "confirm"
      end
    end
    resources :notifications, only: [:index] do
      member do
        patch :mark_as_read
      end
      collection do
        patch :all_mark_as_read
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
