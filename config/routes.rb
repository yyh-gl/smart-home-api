Rails.application.routes.draw do
  get '/weathers', to: 'weathers#speak'
end
