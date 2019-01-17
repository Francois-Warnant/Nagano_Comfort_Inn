class Gestion::ReservationsController < UsersController
  before_filter :set_user
  load_and_authorize_resource

  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    @reservation = Reservation.all
  end

  def new
    @reservation = Reservation.new(user_id: @user.id)
    @room = Room.new
  end

  def create
    @reservation = Reservation.new(params[:reservation])

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
    id = params[:user_id]

    if (id != nil)
      @user = User.find(params[:user_id])
    else
      @user = nil
    end

  end

  private
    def build_reservation(reserv)

      arrival = Date.new reserv["start_date(1i)",].to_i, reserv["start_date(2i)",].to_i, reserv["start_date(3i)",].to_i
      depart = Date.new reserv["end_date(1i)",].to_i, reserv["end_date(2i)",].to_i, reserv["end_date(3i)",].to_i
      demands = reserv["client_demands"]

      current_user.reservations.build({start_date: arrival, end_date: depart, client_demands: demands})
    end
end
