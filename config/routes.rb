Rails.application.routes.draw do
    
    devise_for :users, path: '', path_names: {sign_in: "", sign_out: ""}
    devise_for :admins, path: '', path_names: {sign_in: "welcome/admin_login", sign_out: ""}
    
    resources :users do
        post :deactivate, on: :member
        post :activate, on: :member
    end
      
    resources :products do
        post :deactivate, on: :member
        post :activate, on: :member
    end
    
    resources :orders
    resources :announcements
    
    get '/report', to: "reports#index"
    post '/report', to: "reports#create"
    
    devise_scope :user do
        root to: 'devise/sessions#new'
    end
end
