Rails.application.routes.draw do
  resources :entries
  root "journal#index"
  get "admin", to: "admin#index"
  resources :descriptors
  namespace :admin do
    resources :hunger_levels, :energy_levels, :concentration_levels, :moods
  end
end