Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_for :members, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }

  namespace :public do
    resources :members,only:[:show, :edit, :update]
    get 'members' => 'members#leave'
    patch 'members' => 'members#withdraw'

    resources :products,only:[:index, :show]
    root to: 'homes#top'
    get 'homes/about' => 'homes#about'

    resources :cart_products,only:[:create, :update, :index, :destroy]
    delete 'cart_products' => 'cart_products#destroy_all',as: "cart_product_destroy"

    resources :orders,only:[:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'finish'
      end
    end
    get "search" => 'genres#search'
    get "search_genre" => "genres#search_genre"
    resources :addresses,only:[:index, :create, :destroy, :edit, :update]
  end

  namespace :admin do
    resources :members,only:[:index, :show, :edit, :update]
    resources :products,only:[:index, :new, :create, :show, :edit, :update]
    root to: 'homes#top'
    resources :genres,only:[:index, :create, :edit ,:update]
    resources :orders,only:[:index, :show, :update] do
     resources :order_products,only:[:update]
    end
  end
end
