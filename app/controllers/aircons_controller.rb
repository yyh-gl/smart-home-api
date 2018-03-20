# coding: utf-8
class AirconsController < ApplicationController

  def on
    `python /home/rasp-yyh/smart-home/Remocon/IR-remocon02-commandline.py t aircon_on.dat`
    json_message = "Aircon ON"
    json_response({message: json_message})
  end

  def off
    # TODO: 現状赤外線の学習が不可能のため実装延期
  end
  
end
