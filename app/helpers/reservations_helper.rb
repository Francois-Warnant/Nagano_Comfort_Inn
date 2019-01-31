module ReservationsHelper

  def get_array_room_types
    test = {}
    RoomType.all.each do |rt|
      test.store(rt.id, rt.room_type)
    end
    return test
  end

  def get_today_date
    Date.strptime(Date.today.to_s, "%d-%m-%Y")
  end

  def get_selected_initialised_value(array, index)
    value= 0;
    if (array.count != 0)
      value = array[index]
    end

    value
  end

end
