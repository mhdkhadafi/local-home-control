Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/power" => "tv#power"
  match "/james", to: "tv#james", via: [:get, :put]
  match "/jessica", to: "tv#jessica", via: [:get, :put]
end
