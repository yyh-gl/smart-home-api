# coding: utf-8
class WeathersController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  
  def speak
    `ruby /home/rasp-yyh/smart-home/WeatherForecast/weather.rb`
    json_message = "start weather forecast"
    json_response({message: json_message})
  end

end
