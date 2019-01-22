class Client::ReservationsController < ApplicationController
  before_filter :set_user
  load_and_authorize_resource

  def show
    #@reservation = Reservation.find(@user.id)
  end

  def index
    @reservation = Reservation.find_all_by_user_id(@user.id)
  end

  def new
    @reservation = Reservation.new(user_id: @user.id)
    @room_reservation = @reservation.room_reservations.build()
    @room_type = RoomType.new
    @view_type = ViewType.new
  end

  def create
    @reservation_form = params[:my_reservation]

    res_params = find_room_basic(@reservation_form)
    chosen_room = res_params[:chosen_room]

    if chosen_room != nil
      @reservation = current_user.reservations.build({nb_rooms: 1})
      @reservation.room_reservations.build(room_id: chosen_room.id, start_date: res_params[:start_date], end_date: res_params[:end_date])

      if @reservation.save
        flash[:success] = "NEW RESERVATION ADDED"
        redirect_to my_profile_path
      else
        render 'new'
      end

    else
      redirect_to new_reservation_path, notice: "AUCUNE CHAMBRE DISPONIBLE!"
    end
  end

  def update

  end

  def set_user  # duplicate // should be centralized
    @user = current_user
  end

  private
    def get_date_from_params(date_params)
      return Date.new date_params[:d1].to_i, date_params[:d2].to_i, date_params[:d3].to_i
    end

    def find_room_basic(reservation_form) # version prototype test
      @chosenRoom = nil
      @possible_rooms = []
      @possible_rooms_date = []
      room_res =  reservation_form[:individual_room_reservation]
      room_type = room_res[:room_type]
      view_type = room_res[:view_type]

      arrival = get_date_from_params({ d1: room_res["start_date(1i)"], d2: room_res["start_date(2i)"], d3: room_res["start_date(3i)"] })
      depart = get_date_from_params ({ d1: room_res["end_date(1i)"], d2: room_res["end_date(2i)"], d3: room_res["end_date(3i)"] })

      room_type_id = (RoomType.find_by_room_type(room_type)).id
      view_type_id = (ViewType.find_by_view_type(view_type)).id

      @possible_rooms = Room.where(view_type_id: view_type_id, room_type_id: room_type_id)

      @possible_rooms.each do |possible_room|
        if possible_room.room_reservations.count > 0
          possible_room.room_reservations.each do |rr|

            if rr.start_date.to_date < arrival
              puts possible_room.id
              @possible_rooms_date.push(possible_room)
            end
          end
        else
          @possible_rooms_date.push(possible_room)
        end
      end

      @chosenRoom = @possible_rooms_date.first

      return {chosen_room: @chosenRoom, start_date: arrival, end_date: depart}
    end
end
