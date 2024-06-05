Rails.application.routes.draw do
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'home_countries/index'
    get 'home_countries/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'groups/new'
    get 'groups/index'
    get 'groups/show'
    get 'groups/edit'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'comments/new'
    get 'comments/index'
    get 'comments/show'
    get 'comments/edit'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/mypage'
    get 'users/edit'
    get 'users/show'
    get 'users/confirm'
  end
  namespace :public do
    get 'homes/top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
  }
  
end
