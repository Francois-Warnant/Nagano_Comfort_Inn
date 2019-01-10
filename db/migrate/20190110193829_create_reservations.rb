class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :client_demands

      t.timestamps
    end

    add_index :reservations, [:user_id, :created_at]
    add_index :reservations, [:room_id, :created_at]
    add_index :reservations, [:user_id, :start_date]
    add_index :reservations, [:room_id, :start_date]
    add_index :reservations, [:user_id, :end_date]
    add_index :reservations, [:room_id, :end_date]
    add_index :reservations, [:created_at]
  end
end
