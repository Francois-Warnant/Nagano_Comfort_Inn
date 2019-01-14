class RoomRoomType < ActiveRecord::Base
  attr_accessible :room_id, :room_type_id

  belongs_to :room
  belongs_to :room_type
end
