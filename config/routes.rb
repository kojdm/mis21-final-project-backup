Rails.application.routes.draw do
    devise_for :admins, path: '', path_names: { sign_in: "", sign_out: "" }
    devise_for :users, path: '', path_names: { sign_in: "", sign_out: "" }
    resources :users do
        post :deactivate, on: :member
        post :activate, on: :member
    end
      
    resources :products do
        post :deactivate, on: :member
        post :activate, on: :member
    end
    
    resources :orders
    
    get '/report', to: "reports#index"
    post '/report', to: "reports#create"
    
    
    root 'welcome#index'
end
