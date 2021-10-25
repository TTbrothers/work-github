Rails.application.routes.draw do
  namespace :customer do
    get 'users/show'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
}
# 5.6行目↑どこのコントローラーを参照しているか



# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# ↓'customer'の中のコントローラーを使うよという指定の文
scope module: 'customer' do
#root path
root to: 'homes#top'
get 'about' => 'homes#about'
end

#use namespace "admin"
namespace :admin do
  #root path
  root to: 'homes#top'
  resources :items
  resources :orders, only: [:index, :show, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :order_details, only: [:update]
  resources :genres, only: [:index, :create, :edit, :update]
end

#customer
scope module: :customer do
  resources :items
  resources :genres, only: [:index, :edit, :update]
  resources :addresses, only: [:index, :create, :update, :destroy, :edit]
  #customer order routes
  resources :orders, only: [:new, :create, :index, :show]
  get 'orders/complete', to: 'orders#complete'
  post 'orders/comfirm', to: 'orders#comfirm'
  #customer cart_items routes
  resources :cart_items, only: [:index, :update, :create, :destroy]
  delete 'cart_items/destroy_all', to: 'cart_items#destroy_all'
  put 'cart_items/destroy_all', to: 'cart_items#destroy_all'
  resources :users, only: [:show, :edit]

end


end

