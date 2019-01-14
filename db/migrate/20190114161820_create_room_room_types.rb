class CreateRoomRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_room_types do |t|
      t.integer :room_id
      t.integer :room_type_id

      t.timestamps
    end

    add_index :room_room_types, [:room_id, :room_type_id]
  end
end
