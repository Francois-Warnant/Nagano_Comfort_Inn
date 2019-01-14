class CreateRoomReservations < ActiveRecord::Migration
  def change
    create_table :room_reservations do |t|
      t.integer :reservation_id
      t.integer :room_id

      t.timestamps
    end
  end
end
