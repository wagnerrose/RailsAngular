require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions'}

  # usado para confiugrar subdominios
    namespace :api, defaults: {format: :json}, constraints: {subdomain: 'api'}, path: '/' do
   # namespace :api, defaults: {format: :json} do
      namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
        resources :users, only: [:show, :create, :update, :destroy]
        resources :sessions, only: [:create]
      end
    end
end
