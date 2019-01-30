module RoomsHelper

  def get_room_type_from_room(room)
    RoomType.find_by_id(room.room_type_id).room_type
  end

end
