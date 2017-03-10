Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :whoami, only: [:index, :show]

  namespace :v1 do
    resources :companies, only: [:show]
    resources :accounts, only: [:show]

    resources :companies, module: :companies do
      resources :associations, only: [:index]
      resources :directory, only: [:index, :show, :create, :update]
      resources :teams, only: [:index, :show]

      resources :teams, module: :teams do
        resources :jobs, only: [:index, :show, :update, :create]
        resources :shifts, only: [:index, :show, :update, :create, :destroy]
        resources :workers, only: [:index, :show]
      end
    end
  end
end
