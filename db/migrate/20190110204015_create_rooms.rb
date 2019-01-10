class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :type_id
      t.integer :view_id
      t.integer :floor_no

      t.timestamps
    end
  end
end
