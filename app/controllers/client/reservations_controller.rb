class Client::ReservationsController < ApplicationController
  before_filter :set_user
  load_and_authorize_resource

  def show
    @reservation = Reservation.find(@user.id)
  end

  def index
    @reservation = Reservation.find_all_by_user_id(@user.id)
  end

  def new
    @reservation = current_user.reservations.build({nb_rooms: 1})
    @room_reservation = @reservation.room_reservations.build()
    @nb_rooms = 1

    respond_to do |format|
      format.html { render "new" }
      format.js {render partial: "create"}
    end
  end

  def create
    rooms = params[:rooms]
    chosen_rooms = find_rooms(rooms)

    respond_to do |format|

      if chosen_rooms != nil
        @reservation = current_user.reservations.build({nb_rooms: chosen_rooms.count})

        chosen_rooms.each do |room_params|
          room =  room_params[:chosen_room]
          @reservation.room_reservations.build(room_id: room.id, start_date: room_params[:start_date], end_date: room_params[:end_date])
        end

        if @reservation.save
          format.html { redirect_to my_reservation_path(id: @reservation), notice: 'NEW RESERVATION ADDED' }
          format.js
        else
          format.html { render my_profile_path }
          format.js
        end

      else
        render "new"
      end
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    puts "---------------"
    puts "---------------"
    puts "---------------"
    puts "---------------"
    puts "---------------"
    puts "---------------"
    puts "---------------"
    puts @reservation
    @reservation.room_reservations.each do |rr|
      puts rr.id
      puts rr.start_date
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

    def find_rooms(rooms)
      missing_room = false
      chosen_rooms = []

      rooms.each do |room|
        if !missing_room
          chosen_room = find_room_basic(room, chosen_rooms)
          missing_room = (chosen_room == nil)
          chosen_rooms.push(chosen_room)
        end
      end

      if missing_room
        nil
      else
        chosen_rooms
      end
    end

  def find_possible_rooms(room_params, chosen_rooms) # version prototype test
    @possible_rooms = []
    @possible_rooms_date = []
    room =  room_params[1]
    room_type = room[:room_type]
    view_type = room[:view_type]

    # convertir les params en dates
    arrival = DateTime.parse(room[:check_in])
    depart = DateTime.parse(room[:check_out])

    # Touver toutes les chambres ayant le bon ViewType et RoomType
    @possible_rooms = Room.where(view_type_id: view_type, room_type_id: room_type)

    # Verif simple de la date de debut de réservation   /  A RETRAVAILLER!!!!
    @possible_rooms.each do |possible_room|
      chambre_dispo = true

      if possible_room.room_reservations.count > 0
        possible_room.room_reservations.each do |rr|

          if rr.start_date.to_date <= arrival
            chambre_dispo = false
          end
        end

        if chambre_dispo == true
          @possible_rooms_date.push(possible_room)
        end

      else
        @possible_rooms_date.push(possible_room)
      end
    end

    cpt= 0;
    # Verif que chosen_room n'est pas déja choisi pour cette réservation ()
    while (@chosen_room == nil)
      unless chosen_rooms.include? @possible_rooms_date[cpt]
        @chosen_room = @possible_rooms_date[cpt]
      end

      cpt += 1
    end

    return {chosen_room: @chosen_room, start_date: arrival, end_date: depart}
  end

    def find_room_basic(room_params, chosen_rooms) # version prototype test
      @chosen_room = nil
      @possible_rooms = []
      @possible_rooms_date = []
      room =  room_params[1]
      room_type = room[:room_type]
      view_type = room[:view_type]

      # convertir les params en dates
      arrival = DateTime.parse(room[:check_in])
      depart = DateTime.parse(room[:check_out])

      # Touver toutes les chambres ayant le bon ViewType et RoomType
      @possible_rooms = Room.where(view_type_id: view_type, room_type_id: room_type)

      # Verif simple de la date de debut de réservation   /  A RETRAVAILLER!!!!
      @possible_rooms.each do |possible_room|
        chambre_dispo = true

        if possible_room.room_reservations.count > 0
          possible_room.room_reservations.each do |rr|

            if rr.start_date.to_date <= arrival
              chambre_dispo = false
            end
          end

          if chambre_dispo == true
            @possible_rooms_date.push(possible_room)
          end

        else
          @possible_rooms_date.push(possible_room)
        end
      end

      cpt= 0;
      # Verif que chosen_room n'est pas déja choisi pour cette réservation ()
      while (@chosen_room == nil)
        unless chosen_rooms.include? @possible_rooms_date[cpt]
          @chosen_room = @possible_rooms_date[cpt]
        end

        cpt += 1
      end

      return {chosen_room: @chosen_room, start_date: arrival, end_date: depart}
    end
end
