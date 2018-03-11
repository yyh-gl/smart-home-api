Rails.application.routes.draw do
  get '/weathers', to: 'weathers#speak'
  get '/alarms', to: 'alarms#index'
  post '/alarms/:time', to: 'alarms#ring'
  delete '/alarms/:time', to: 'alarms#delete'
end
