class Gestion::ReservationsController < Gestion::GestionController
  before_filter :set_user
  load_and_authorize_resource

  def index
    if (@user == nil)
      @reservation = Reservation.all
    else
      @reservation= []
      @user.reservations.all.each do |r|
        @reservation.push r.room_reservations.all
      end
    end

  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.create(build_params(params))

    if @reservation.save
      flash[:success] = "NEW RESERVATION ADDED"

      redirect_to gestion_reservations_path
    else
      render 'new'
    end
  end

  def set_user  #temp
    id = params[:user_id]

    if (id != nil)
      @user = User.find(params[:user_id])
    else
      @user = nil
    end

  end

  private
    def build_params(params)
      params_reservation= params[:reservation]
      id = User.find_by_email(params_reservation[:user_id]).id

      params_reservation[:user_id] = id

      return params_reservation
    end
end