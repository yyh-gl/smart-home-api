# coding: utf-8
class AlarmsController < ApplicationController

  def ring
    wake_up_time = params[:time].to_i
    loop do
      break if Time.now.strftime("%H%M").to_i >= wake_up_time
      sleep 5
    end
    `/usr/bin/jsay.sh #{"起きろー。" * 10}`
    head :ok
  end
  
end
