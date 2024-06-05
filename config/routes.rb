Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root to:'homes#top'
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :home_countries, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
    root to:'homes#top'
    get '/my_page' => 'users#mypage'
    get '/unsubscribe' => 'users#unsubscribe'
    get '/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :show, :update]
    resources :posts do
      resources :comments
      resource :favorite, only: [:create, :destroy, :index]
    end
    resources :groups do
      resource :group_user, only: [:create, :destroy]
    end
  end
end
