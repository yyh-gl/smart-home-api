class Alarm < ApplicationRecord
  validates :reservation_date, presence: true
end
