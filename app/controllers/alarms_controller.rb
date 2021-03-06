# coding: utf-8
class AlarmsController < ApplicationController
  before_action :get_reservation_datetime, only: [:ring, :delete]

  # GET /alarms
  def index
    # 現在以降のアラーム予約日時のみ取得
    # TODO: 時間だけで取ると明日の同時間の予約が取得できないので、時間だけでなく日時で予約を取得できるように修正する
    @reservation_date = Alarm.where("reservation_date >= ?", Time.now)
    json_response(@reservation_date)
  end
  
  # GET /alarms/:time
  def ring
    if params[:time] == '0'
      stop
      json_message = "stop alarm"
    else
      `/home/rasp-yyh/smart-home/Alarm/alarm.sh #{@wake_up_time}`
      save_reservation_datetime(@wake_up_datetime)
      json_message = "set alarm at #{@wake_up_datetime}"
    end
    json_response({message: json_message})
  end

  # DELETE /alarms/:time
  def delete
    delete_reservation_datetime(@wake_up_datetime)
    `at -l | grep #{@wake_up_time} | awk '{print $1}' | xargs at -d`
    json_message = "delete alarm at #{@wake_up_datetime}"
    json_response({message: json_message})
  end

  private
  
  def stop
    `pidof /usr/bin/mpg321 | xargs kill -9`
  end

  def save_reservation_datetime(reservation_datetime)
    Alarm.create!(reservation_date: "#{reservation_datetime}")
  end

  def delete_reservation_datetime(reservation_datetime)
    Alarm.where("reservation_date like '%" + reservation_datetime + "%'").delete_all
  end

  def get_reservation_datetime
    return if params[:time] == '0'
    @wake_up_time = params[:time].clone
    @wake_up_time.insert(-3, ':')
    today = Time.current
    if params[:time].to_i >= today.strftime("%H%M").to_i
      @wake_up_datetime = today.strftime("%Y-%m-%d ") << @wake_up_time
    else
      @wake_up_datetime = today.tomorrow.strftime("%Y-%m-%d ") << @wake_up_time
    end
  end

end
