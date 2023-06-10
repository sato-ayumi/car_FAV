Rails.application.routes.draw do

  get "/search", to: "searches#search",  as: "search"
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root "homes#top"
  end
   
      # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root "homes#top"
    get "about" => "homes#about", as: "about"
    get "users/:id/unsubscribe", to: "users#unsubscribe", as: "unsubscribe"
    patch "users/:id/withdraw", to: "users#withdraw", as: "withdraw_user"
    resources :users, only: [:show, :edit, :update]
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      collection do
        get "confirm"
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
