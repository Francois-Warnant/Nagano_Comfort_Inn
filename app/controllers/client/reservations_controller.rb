class Client::ReservationsController < Client::ClientController
  before_filter :set_user #Nécessaire??

  def show
    @reservation = Reservation.find(@user.id)
  end

  def index
    @reservation = Reservation.find_all_by_user_id(@user.id)
  end

  def new
    puts "GENERAL PARAMS : "
    puts params
    @check_in = get_value_from_params(params, :check_in)
    @check_out = get_value_from_params(params, :check_out)
    @nb_rooms = get_value_from_params(params, :nb_rooms)

    @view_types = get_types_from_params(params, :view_types, @nb_rooms)
    @room_types = get_types_from_params(params, :room_types, @nb_rooms)

    @chosen_rooms_ids = add_room(params)
    @chosen_rooms = Room.find(@chosen_rooms_ids)

    if params[:check_in] != nil
      @rooms = find_possible_rooms(params)
    else
      @rooms = Room.all
    end

    respond_to do |format|
      format.html { }
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
        rooms = params[:chosen_rooms].split(", ")
      end

      if params[:added_room] != nil
        rooms.push(params[:added_room].split(","))
        puts rooms
      end

      return rooms
    end

    def get_value_from_params(params, key)
      info = nil

      if params[key.to_sym] != nil
        if key == :check_in || key == :check_out
          info = params[key.to_sym].to_date
        elsif (key == :nb_rooms || key == :room_type || key == :view_type)
          info = params[key.to_sym].to_i
        else
          info = params[key.to_sym]
        end
      end

      if info.nil?
        if key == :nb_rooms
          info = 0
        elsif key == :view_type || key == :room_type
          info = 1
        end
      end

      info
    end

  def get_types_from_params(params, key, nb_rooms)
    info = []
    types = params[:types]

    if types != nil
      types.each do |t|
        temp = t[1]
        if key == :room_types
          info.push (temp[:room_type].to_i)
        elsif key == :view_types
          info.push (temp[:view_type].to_i)
        end
      end
    else
      # si le type est nul
    end

    info
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

end
