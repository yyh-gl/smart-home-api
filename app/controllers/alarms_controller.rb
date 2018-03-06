# coding: utf-8
class AlarmsController < ApplicationController

  # GET /alarms
  def index
    # 現在以降のアラーム予約日時のみ取得
    @reservation_date = Alarm.where("reservation_date >= ?", Time.now)
    json_response(@reservation_date)
  end
  
  # GET /alarms/:time
  def ring
    if params[:time] == '0'
      stop
      json_message = "stop alarm"
    else
      today = Time.current      
      if params[:time].to_i >= today.strftime("%H%M").to_i
        wake_up_date = today.strftime("%Y/%m/%d - ")
      else
        wake_up_date = today.tomorrow.strftime("%Y/%m/%d - ")
      end
      wake_up_time = params[:time].insert(-3, ':')
      `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{wake_up_time}`
       wake_up_date << wake_up_time
      json_message = "set alarm at #{wake_up_date}"
    end
    json_response({message: json_message})
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end
  
end
