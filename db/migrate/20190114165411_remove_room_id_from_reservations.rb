class RemoveRoomIdFromReservations < ActiveRecord::Migration
  def up
    remove_column :reservations, :room_id
  end

  def down
    add_column :reservations, :room_id, :integer
  end
end
