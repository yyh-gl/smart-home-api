# coding: utf-8
class WeathersController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  
  def speak
    json = get_weather
    text = make_text json
    `say #{text}`
    head :ok
  end

  private

  def get_weather
    uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=260010')
    json = Net::HTTP.get(uri)  
    parsed_json = JSON.parse(json)
    make_text parsed_json
  end

  def make_text parsed_json
    text = "" + parsed_json['title'] + parsed_json['description']['text']
    text.gsub(/(\r\n?|\n)/, "").gsub(/[\s ]/, "、")
  end

end
