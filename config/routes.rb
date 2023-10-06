Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
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

    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => "users#edit"
    patch 'users/infomation' => 'users#update'
    get 'users/confirm' => 'user#confirm'
    patch 'users/deactivate' => 'users#deactivate'

    resources :coordinates
    resources :bookmarks, only: [:index, :create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
