Greenbean::Application.routes.draw do
  devise_for :merchants, :users

  namespace :api do
    get 'docs/index'
    match 'docs' => 'docs#index'
    match "/matrix/min_weigth" => "matrixs#min_weigth_path", :via  => :post

    namespace :merchant do
      
      resources :raffles, :only => [:create, :destroy]
      
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

    namespace :consumer do
      resources :sessions, :only  => [:create] do
        collection do
          post :delete
        end
      end
      resources :beans do
        collection do
          get :validate
        end
      end
    end
  end

  root :to => 'api/docs#index'
end

