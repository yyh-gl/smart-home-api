# coding: utf-8
class AlarmsController < ApplicationController

  def ring
    wake_up_time = params[:time].insert(-3, ':')
    `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{wake_up_time}`
    head :ok
  end
  
end
