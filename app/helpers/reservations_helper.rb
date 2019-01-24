module ReservationsHelper

  def getAArrayRoomTypes
    test = {}
    RoomType.all.each do |rt|
      test.store(rt.id, rt.room_type)
    end
    return test
  end
end
