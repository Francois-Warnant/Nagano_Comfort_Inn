namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    total_rooms = 200
    current_floor = 0

    RoomType.create!(room_type: "Simple")
    RoomType.create!(room_type: "Double")
    RoomType.create!(room_type: "Deluxe")
    RoomType.create!(room_type: "Presidential")
    ViewType.create!(view_type: "Ocean")
    ViewType.create!(view_type: "Jungle")

    total_rooms.times do |n|
      if is_floor_diff n, current_floor
        current_floor+= 1
      end

      room = makeRoomNo n, current_floor
      Room.create!(floor_no: current_floor, room_no: room)
    end

    total_rooms.times do |n|
      room = Room.find(n+1)

      room.create_room_room_type(room_type_id: ((n+1) % 4)) 
      room.create_room_view_type(view_type_id: ((n+1) % 2))
    end
  end
end

def is_floor_diff (n, current_floor)
  if (n % 25) == 0
    true
  else
    false
  end
end

def makeRoomNo (n, current_floor)
  if (((n % 25) + 1) < 10)
    (current_floor.to_s + "0" + ((n % 25) + 1).to_s).to_i
  else
    (current_floor.to_s + ((n % 25) + 1).to_s).to_i
  end
end