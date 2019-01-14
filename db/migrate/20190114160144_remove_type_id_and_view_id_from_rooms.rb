class RemoveTypeIdAndViewIdFromRooms < ActiveRecord::Migration
  def up
    remove_column :rooms, :type_id
    remove_column :rooms, :view_id
  end

  def down
    add_column :rooms, :type_id, :integer
    add_column :rooms, :view_id, :integer
  end
end
