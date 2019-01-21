class AjoutDatesReservationChambres < ActiveRecord::Migration
  def change
    add_column :room_reservations, :start_date, :datetime
    add_column :room_reservations, :end_date, :datetime
    add_column :reservations, :nb_rooms, :integer

    remove_column :reservations, :start_date
    remove_column :reservations, :end_date
  end
end
