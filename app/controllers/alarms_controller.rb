# coding: utf-8
class AlarmsController < ApplicationController

  def ring
    stop if params[:time] == '0'
    wake_up_time = params[:time].insert(-3, ':')
    `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{wake_up_time}`
    head :ok
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end
  
end
