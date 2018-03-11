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
      wake_up_date = get_wake_up_date(params[:time])
      save_reservation_date(wake_up_date)
      json_message = "set alarm at #{wake_up_date}"
      # TODO: params[:time]'s name is OK?'
      `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{params[:time]}`
    end
    json_response({message: json_message})
  end

  # DELETE /alarms/:time
  def delete
    wake_up_date = get_wake_up_date(params[:time])
    delete_reservation_date(wake_up_date)
    json_message = "delete alarm at #{wake_up_date}"
    `at -l | grep #{params[:time]} | awk '{print $1}' | xargs at -d`
    json_response({message: json_message})
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end

  def save_reservation_date(wake_up_date)
    Alarm.create!(reservation_date: "#{wake_up_date}")
  end

  def delete_reservation_date(wake_up_date)
    Alarm.where("reservation_date like '%" + wake_up_date + "%'").delete_all
  end

  def get_wake_up_date(time)
    wake_up_time = time.insert(-3, ':')
    today = Time.current
    if time.to_i >= today.strftime("%H%M").to_i
      return today.strftime("%Y-%m-%d ") << wake_up_time
    end
    return today.tomorrow.strftime("%Y-%m-%d ") << wake_up_time
  end

end
