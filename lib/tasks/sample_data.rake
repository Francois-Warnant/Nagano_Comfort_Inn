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

    Role.create!(name: "admin")
    Role.create!(name: "client")
    Role.create!(name: "employee")
    Role.create!(name: "cleaning")

    total_rooms.times do |n|
      if is_floor_diff n
        current_floor+= 1
      end

      room = makeRoomNo n, current_floor
      view_id= (((n) % 4) + 1)
      room_id= (((n) % 2) + 1)
      Room.create!(floor_no: current_floor, room_no: room, view_type_id: view_id, room_type_id: room_id)
    end
  end
end

def is_floor_diff (n)
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