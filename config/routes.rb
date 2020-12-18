Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'posts#following_feed', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show]

  resources :posts

  resources :posts do
    resources :comments, only: [:create, :update, :destroy] do
      member do
        post :ajax_feed_comment
      end
    end
  end

  get "/following_feed", to: "posts#following_feed"
  get "/activity", to: "posts#activity"
  get "/saved_posts", to: "saved_posts#saved_posts"

  resources :video_posts

  resources :video_posts do
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

  resources :saved_posts, only: [:update] do
    member do
      put :ajax_saved_posts
    end
  end

  resources :conversations do
    resources :messages
  end
end
