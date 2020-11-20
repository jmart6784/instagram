Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show]

  resources :posts

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :likes, only: [:update] do
    member do
      put :ajax_likes_update
    end
  end

  resources :follows, only: [:update] do
    member do
      put :ajax_follows_update
    end
  end
end
