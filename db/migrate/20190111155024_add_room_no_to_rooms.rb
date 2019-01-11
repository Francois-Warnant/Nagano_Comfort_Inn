class AddRoomNoToRooms < ActiveRecord::Migration
  def up
    add_column :rooms, :room_no, :integer
  end

  def down
    remove_column :rooms, :room_no
  end
end
