class AddViewTypeRoomTypeToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :room_type_id, :integer
    add_column :rooms, :view_type_id, :integer
  end
end
