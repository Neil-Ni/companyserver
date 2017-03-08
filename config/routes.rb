Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :whoami, only: [:index]

  namespace :v1 do
    resources :companies, only: [:show]

    resources :companies, module: :companies do
      resources :teams, only: [:index, :show]

      resources :teams, module: :teams do
        resources :jobs, only: [:index, :show]
        resources :shifts, only: [:index, :show]
        resources :workers, only: [:index, :show]
      end
    end
  end
end
