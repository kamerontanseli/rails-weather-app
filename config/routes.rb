Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "locations#index"

  with_options(except: [:show]) do |opt|
    opt.resources :locations
  end
  get "/locations/:city", to: "locations#show", as: "locations_show"
  get "/locations/:city/weather", to: "locations#weather", as: "weather_api_location"
  get "/cities", to: "locations#cities", as: "cities_api_location"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
