Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#resource :weathers, only: [:index] do
#  get "/info", action: 'show'
#end

get '/weathers', to: 'weathers#index'
get '/weathers/info', to: 'weathers#info'

end
