Greenbean::Application.routes.draw do
  devise_for :merchants

  namespace :api do
    get 'docs/index'
    match 'docs' => 'docs#index'
    resources :beans
    resources :sessions, :only  => [:create] do 
      collection do 
        post :delete
      end
    end
    resources :tokens, :only => [:create] do 
      collection do 
        get :beans
      end
    end
  end
  
end
