# coding: utf-8
class AlarmsController < ApplicationController

  def ring
    if params[:time] == '0'
      stop
      json_response("stop alarm")
    else
      wake_up_time = params[:time].insert(-3, ':')
      `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{wake_up_time}`
      json_response("set alarm at #{wake_up_time}")
    end
    # head :ok    
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end
  
end
