Rails.application.routes.draw do
  root 'static_pages#home'
  get '/:locale' => 'static_pages#home'
  scope '/:locale', locale: /#{I18n.available_locales.join("|")}/ do

    get 'help' => 'static_pages#help'
    get 'privacy' => 'static_pages#privacy'
    get 'about' => 'static_pages#about'
    get 'contact' => 'static_pages#contact'
    get 'signup' => 'users#new'
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    resources :users
    resources :account_activations, only: [:edit]
    resources :password_resets, only: %i[new create edit update]
    resources :projects, only: %i[index create update destroy]
    resources :tasks, only: %i[create update] do
      put :destroy, on: :collection
      put :complete, on: :member
      put :prioritize, on: :member
    end
  end
  get '/auth/:service/callback', to: 'services#create'
  resources :services, only: %i[index create destroy]
end
