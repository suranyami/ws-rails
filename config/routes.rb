Rails.application.routes.draw do
  resources :statuses do
    collection do
      get :register
    end
  end

  root to: 'statuses#index'

end
