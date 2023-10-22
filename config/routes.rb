Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:show, :update]
    resources :coordinates, only: [:index, :show, :destroy]
  end


  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    resources :users, only: [:show, :edit, :update] do
      member do
        patch :deactivate
        get :posts
        get :bookmarks
      end
    end
    resources :coordinates do
      resource :bookmarks, only: [:create, :destroy]
      collection do
        get :random
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
