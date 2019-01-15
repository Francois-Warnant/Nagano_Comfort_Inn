class DropAssociationTablesForRoomTypeAndViewType < ActiveRecord::Migration
  def up
    drop_table :room_room_types
    drop_table :room_view_types
  end

  def down
    create_table :room_view_types do |t|
      t.integer :room_id
      t.integer :view_type_id

      t.timestamps
    end

    create_table :room_room_types do |t|
      t.integer :room_id
      t.integer :room_type_id

      t.timestamps
    end

    add_index :room_room_types, [:room_id, :room_type_id]
    add_index :room_view_types, [:room_id, :view_type_id]
  end
end
