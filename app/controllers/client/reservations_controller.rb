class Client::ReservationsController < Client::ClientController
  before_filter :set_user #Nécessaire??

  def show
    @reservation = Reservation.find(@user.id)
  end

  def index
    @reservation = Reservation.find_all_by_user_id(@user.id)
  end

  def new
    puts "NEW PARAMS : "
    puts params

    @rooms = []
    @cpt_steps = init_steps(params)
    @chosen_rooms = get_rooms_from_params(params, :room)
    @check_in = get_value_from_params(params, :check_in)
    @check_out = get_value_from_params(params, :check_out)
    @nb_rooms = get_value_from_params(params, :nb_rooms)
    @demands = get_value_from_params(params, :demands)

    @view_types = get_types_from_params(params, :view_types)
    @room_types = get_types_from_params(params, :room_types)

    if (@cpt_steps >= 3) #CONSTANTE!
      @nb_rooms.times do |i|
        @rooms.push(find_possible_rooms(@check_in, @check_out, @view_types[i], @room_types[i]))
      end
    end

    respond_to do |format|
      format.html { }
      format.js {
        render partial: "new", cpt_steps: @cpt_steps, nb_rooms: @nb_rooms
      }
    end
  end

  def create
    puts "CREATE PARAMS : "
    puts params
    chosen_rooms = params[:rooms].split(" ")

    respond_to do |format|

      if chosen_rooms != nil
        @reservation = current_user.reservations.build({nb_rooms: chosen_rooms.count, client_demands: params[:demands]})

        chosen_rooms.each do |r|
          @reservation.room_reservations.build(room_id: r, start_date: params[:check_in], end_date: params[:check_out])
        end

        if @reservation.save
          format.html { redirect_to my_profile_path(notice: 'NEW RESERVATION ADDED') }
          format.js {  }
        else
          format.html { render my_reservations_path }
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

  def set_user 
    @user = current_user
  end



  # # # #
  # Private methods
  # # # #


  private

    def init_steps(params) # faire validation + messages de gestion
      cpt = 0

      if params[:cpt_steps] != nil
        cpt = params[:cpt_steps].to_i

        if params[:commit] == "NEXT"
          cpt += 1
        elsif params[:commit] == "BACK"
          if cpt > 0
            cpt -= 1
          end
        end
      end

      cpt
    end


      ################# regrouper ####################
    def get_value_from_params(params, key)
      info = nil

      if params[key.to_sym] != nil
        if key == :check_in || key == :check_out
          info = params[key.to_sym].to_date
        elsif key == :nb_rooms || key == :room_type || key == :view_type
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

    def get_types_from_params(params, key) # faire passer par get_value_from_params
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
      end

      info
    end

  def get_rooms_from_params(params, key) # faire passer par get_value_from_params
    info = []
    rooms = params[:rooms]

    if rooms != nil
      rooms.each do |t|
        temp = t[1]
        info.push (temp[key.to_sym].to_i)
      end
    end

    info
  end

#########################################################

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
    def find_possible_rooms(check_in, check_out, view_type, room_type)
      possible_rooms = []
      possible_rooms_date = []

      # convertir les params en dates
      arrival = check_in
      depart = check_out

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
