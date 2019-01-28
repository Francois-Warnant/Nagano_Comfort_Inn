module RoomReservationsHelper

  def getRoomTypeForRoom(room)
    (RoomType.find_by_id(room.room_type_id)).room_type
  end

  def getViewTypeForRoom(room)
    (ViewType.find_by_id(room.view_type_id)).view_type
  end
end
