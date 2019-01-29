module Gestion
  class Users::ReservationsController < UsersController
    before_filter :set_user

    def show
      @reservation = Reservation.find(params[:id])
    end

    def index
      @reservation = @user.reservations.all
    end

    def new
      @reservation = Reservation.new(user_id: @user.id)
      @room = Room.new
    end

    def create
      puts "test"
      build_reservation(params[:reservation])

      if @reservation.save
        flash[:success] = "NEW RESERVATION ADDED"
        redirect_to current_user
      else
        render 'new'
      end
    end

    def update

    end

    def set_user  #temp
      @user = User.find(params[:user_id])
    end

    private
      def build_reservation(reserv)
        room_res = reserv[:room_reservation]
        puts "-------------------------------------------------------------------------------------------------------"
        puts room_res
        arrival = Date.new room_res["start_date(1i)",].to_i, reserv["start_date(2i)",].to_i, reserv["start_date(3i)",].to_i
        depart = Date.new room_res["end_date(1i)",].to_i, reserv["end_date(2i)",].to_i, reserv["end_date(3i)",].to_i
        demands = reserv["client_demands"]

        current_user.reservations.build({start_date: arrival, end_date: depart, client_demands: demands})
      end
  end
end
