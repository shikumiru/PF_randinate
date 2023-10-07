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

  scope module: :public do
    root to: 'homes#top'

    get 'mypage' => 'users#show'
    get 'information/edit' => "users#edit"
    patch 'infomation' => 'users#update'
    get 'confirm' => 'user#confirm'
    patch 'deactivate' => 'users#deactivate'

    resources :coordinates
    resources :bookmarks, only: [:index, :create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
