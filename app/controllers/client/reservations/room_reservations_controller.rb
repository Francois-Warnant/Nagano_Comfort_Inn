module Client
	class Reservations::RoomReservationsController < ReservationsController

	  def show

	  end

	  def index
			puts
			@reservation = Reservation.find(params[:id])
			@room_reservations = @reservation.room_reservations

			respond_to do |format|
				format.html
				format.js {render partial: "client/reservations/room_reservations/edit"}
			end
	  end

		def edit

			respond_to do |format|
				format.html
				format.js {render partial: "client/reservations/room_reservations/edit"}
			end
		end
	end
end