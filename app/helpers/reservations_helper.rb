module ReservationsHelper

  def getAArrayRoomTypes
    test = {}
    RoomType.all.each do |rt|
      test.store(rt.id, rt.room_type)
    end
    return test
  end

  def getTodaysDate
    Date.strptime(Date.today.to_s, "%d-%m-%Y")
  end
end
