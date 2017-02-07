require 'api_constraints'

Rails.application.routes.draw do
  get 'welcome/index'

  def api_version(version, &routes)
    api_constraints = APIConstraints.new(version: version)

    # comment out below line and uncommment namespace lines below to use url based versioning mechanism,
    # right now its header based
    scope module: "api/v#{version}", constraints: api_constraints, defaults: { format: :json }, &routes
  end

  api_version(1) do
    # namespace :api do
    #  namespace :v1 do
        resources :articles do
          resources :comments
        end
    #  end
    # end
  end

  api_version(2) do
   # namespace :api do
   #   namespace :v2 do
        resources :articles do
          resources :comments
        end
   #   end
   # end
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end