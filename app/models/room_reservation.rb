# == Schema Information
#
# Table name: room_reservations
#
#  id             :integer          not null, primary key
#  reservation_id :integer
#  room_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :room_id

  belongs_to :reservation
  belongs_to :room
end