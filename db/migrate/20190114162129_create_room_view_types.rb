class CreateRoomViewTypes < ActiveRecord::Migration
  def change
    create_table :room_view_types do |t|
      t.integer :room_id
      t.integer :view_type_id

      t.timestamps
    end

    add_index :room_view_types, [:room_id, :view_type_id]
  end
end
