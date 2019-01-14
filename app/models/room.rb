# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  floor_no   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_no    :integer
#

class Room < ActiveRecord::Base
  attr_accessible :floor_no, :room_no

  has_many :room_reservations
  has_many :reservations, through: :room_reservations

  has_one :room_room_type
  has_one :room_type, through: :room_room_type

  has_one :room_view_type
  has_one :view_type, through: :room_view_type
end
