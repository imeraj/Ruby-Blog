require 'api_constraints'

Rails.application.routes.draw do
  get 'welcome/index'

  def api_version(version, &routes)
    api_constraints = APIConstraints.new(version: version)
    scope module: "v#{version}", constraints: api_constraints, defaults: { format: :json }, &routes
  end

  api_version(1) do
    resources :articles do
      resources :comments
    end
  end

  api_version(2) do
    resources :articles do
      resources :comments
    end
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end