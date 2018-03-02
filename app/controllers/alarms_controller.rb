# coding: utf-8
class AlarmsController < ApplicationController

  def ring
    if params[:time] == '0'
      stop
      json_message = "stop alarm"
    else
      today = Time.current
      wake_up_time = params[:time].insert(-3, ':')
      `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{wake_up_time}`
      if params[:time].to_i >= Time.now.strftime("%H%M").to_i
        wake_up_date = today.strftime("%Y/%m/%d - ") + wake_up_time
      else
        wake_up_date = today.tomorrow.strftime("%Y/%m/%d - ") + wake_up_time
      end
      json_message = "set alarm at #{wake_up_date}"      
    end
    json_response({message: json_message})
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end
  
end
