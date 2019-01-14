# == Schema Information
#
# Table name: room_room_types
#
#  id           :integer          not null, primary key
#  room_id      :integer
#  room_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class RoomRoomType < ActiveRecord::Base
  attr_accessible :room_id, :room_type_id

  belongs_to :room
  belongs_to :room_type
end
