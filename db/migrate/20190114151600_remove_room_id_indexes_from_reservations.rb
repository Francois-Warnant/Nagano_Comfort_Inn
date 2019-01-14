class RemoveRoomIdIndexesFromReservations < ActiveRecord::Migration
  def change
    remove_index "reservations", name: "index_reservations_on_room_id_and_created_at"
    remove_index "reservations", name: "index_reservations_on_room_id_and_end_date"
    remove_index "reservations", name: "index_reservations_on_room_id_and_start_date"
  end
end
