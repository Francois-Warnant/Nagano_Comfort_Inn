class ChangeColumnsFromNameType < ActiveRecord::Migration
  def change
    rename_column :room_types, :type, :room_type
    rename_column :view_types, :type, :view_type
  end
end
