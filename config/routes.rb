Rails.application.routes.draw do
  get '/weathers', to: 'weathers#speak'
  get '/alarms/:time', to: 'alarms#ring'
end
