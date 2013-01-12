Greenbean::Application.routes.draw do
  devise_for :merchants

  namespace :api do 
    resources :sessions, :only  => [:create] do 
      collection do 
        post :delete
      end
    end
  end
  
end
