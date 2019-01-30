class Client::ReservationsController < Client::ClientController
  before_filter :set_user #Nécessaire??

  def show
    @reservation = Reservation.find(@user.id)
  end

  def index
    @reservation = Reservation.find_all_by_user_id(@user.id)
  end

  def new
    puts params
    @reservation = current_user.reservations.build({nb_rooms: 1})
    @room_reservation = @reservation.room_reservations.build()
    @check_in = get_date_from_params(params, :check_in)
    @check_out = get_date_from_params(params, :check_in)
    @chosen_rooms = add_room(params)

    if params[:check_in] != nil
      @rooms = find_possible_rooms(params)
    else
      @rooms = Room.all
    end

    @nb_rooms = 1

    respond_to do |format|
      format.html {  }
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
  end

  def update

  end

  def set_user  # duplicate // should be centralized
    @user = current_user
  end



  # # # #
  # Private methods
  # # # #


  private

    def add_room(params)
      rooms = []

      if params[:chosen_rooms] != nil
        rooms = params[:chosen_rooms].split(",")
      end

      if params[:added_room] != nil
        rooms += params[:added_room].split(",")
      end

      return rooms
    end

    def get_date_from_params(params, key)
      date = nil;
      search_params = params[:search_params]

      if params[key.to_sym] != nil
        date = params[key.to_sym].to_date

      elsif search_params[0] != nil
        if search_params[key] != nil
          date = search_params[key.to_sym]
        end
      end

      date
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

    # Devra retourner un array de chambres disponibles pour la sélection
    def find_possible_rooms(params) # version prototype test
      possible_rooms = []
      possible_rooms_date = []
      room_type = params[:room_type]
      view_type = params[:view_type]

      # convertir les params en dates
      arrival = DateTime.parse(params[:check_in])
      depart = DateTime.parse(params[:check_out])

      # Touver toutes les chambres ayant le bon ViewType et RoomType
      possible_rooms = Room.view_types(view_type).room_types(room_type)

      # Verif simple de la date de debut de réservation   /  A RETRAVAILLER!!!!
      possible_rooms.each do |possible_room|
        chambre_dispo = true

        # Si le nombre de réservation accrocher à la chambre est plus grand que 0
        if possible_room.room_reservations.count > 0
          possible_room.room_reservations.each do |rr|

            # si la date d'arrivée est plus tard que les dates de réservation de la chambre
            chambre_dispo = date_validation_room_selection(rr, arrival, depart)
          end

          # Si la chambre est disponible (voir CHECK DATE)
          if chambre_dispo == true
            possible_rooms_date.push(possible_room)
          end

        else
          possible_rooms_date.push(possible_room)
        end
      end

      # Retourne un tableau de plusieurs chambres valides
      return possible_rooms_date
    end

    # Valide si la chambre est libre selon les dates de check-in et check-out
    def date_validation_room_selection(room_reservation, check_in, check_out) # A completer
      is_valid = false
      limit_date = room_reservation.start_date + 7.days

      if room_reservation.start_date.to_date < check_in && room_reservation.end_date.to_date < check_in ||
          room_reservation.start_date.to_date > check_out && room_reservation.end_date.to_date > check_out
        is_valid = true

      #elsif room_reservation.start_date.to_date > arrival # gérer les 7 jours
      end

      is_valid
    end


    ##
    # LEGACY CODE (kept for reference)
    ##

    def old_find_rooms(rooms)
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

    # Devra retourner un array de chambres disponibles pour la sélection
    def old_find_possible_rooms(room_params, chosen_rooms) # version prototype test
      @possible_rooms = []
      @possible_rooms_date = []
      room =  room_params[1]
      room_type = room[:room_type]
      view_type = room[:view_type]

      # convertir les params en dates
      arrival = DateTime.parse(room[:check_in])
      depart = DateTime.parse(room[:check_out])

      # Touver toutes les chambres ayant le bon ViewType et RoomType
      @possible_rooms = Room.view_types(view_type).room_types(room_type)  #Room.where(view_type_id: view_type, room_type_id: room_type)


      # Verif simple de la date de debut de réservation   /  A RETRAVAILLER!!!!
      @possible_rooms.each do |possible_room|
        chambre_dispo = true

        # Si le nombre de réservation accrocher à la chambre est plus grand que 0
        if possible_room.room_reservations.count > 0
          possible_room.room_reservations.each do |rr|

            # si la date d'arrivée est plus tard que les dates de réservation de la chambre // TEMPORAIRE + FAIRE FULL CHECK
            if rr.start_date.to_date <= arrival
              chambre_dispo = false
            end
          end

          # Si la chambre est disponible (voir CHECK DATE)
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

      # Retourne un tableau de plusieurs chambres valides
      return {chosen_room: @chosen_room, start_date: arrival, end_date: depart}
    end

    # Retourne une chambre libre correspondant au paramêtres de sélection.
    # ne prend pas encore en compte les chambres d'une même réservation.
    def find_room_basic(room_params, chosen_rooms)
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
      @possible_rooms = Room.view_types(view_type).room_types(room_type)

      # Verif simple de la date de debut de réservation   /  A RETRAVAILLER!!!!
      @possible_rooms.each do |possible_room|
        chambre_dispo = true

        # Si le nombre de réservation accrocher à la chambre est plus grand que 0

        if possible_room.room_reservations.count > 0
          possible_room.room_reservations.each do |rr|

            # si la date d'arrivée est plus tard que les dates de réservation de la chambre // TEMPORAIRE + FAIRE FULL CHECK
            if rr.start_date.to_date <= arrival
              chambre_dispo = false
            end
          end

          # Si la chambre est disponible (voir CHECK DATE)
          if chambre_dispo == true
            @possible_rooms_date.push(possible_room)
          end

        else
          @possible_rooms_date.push(possible_room)
        end
      end

      cpt= 0
      # Verif que chosen_room n'est pas déja choisi pour cette réservation () # à revoir
      #while (@chosen_room == nil)
        #unless chosen_rooms.include? @possible_rooms_date[cpt]
          #@chosen_room = @possible_rooms_date[cpt]
        #end

        #cpt += 1
      #end

      puts "FINAL"
      puts @chosen_room
      @chosen_room = @possible_rooms_date.first()

      # Retourne UNE chambre valide.
      return {chosen_room: @chosen_room, start_date: arrival, end_date: depart}
    end
end
