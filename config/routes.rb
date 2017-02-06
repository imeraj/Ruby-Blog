require 'api_constraints'

Rails.application.routes.draw do
  get 'welcome/index'

    scope module: :v1, constraints: APIConstraints.new(version: 1, defualt: true), defaults: { format: 'json' } do
      resources :articles do
        resources :comments
      end
    end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
