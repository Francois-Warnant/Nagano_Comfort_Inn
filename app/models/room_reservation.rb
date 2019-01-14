class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :room_id

  belongs_to :reservation
  belongs_to :room
end
