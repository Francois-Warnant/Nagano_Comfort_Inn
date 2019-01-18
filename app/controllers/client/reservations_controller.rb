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
    @room_type = RoomType.new
    @view_type = ViewType.new
  end

  def create
    @reservation = build_reservation params[:reservation]


    if @reservation.save
      flash[:success] = "NEW RESERVATION ADDED"
      redirect_to my_profile_path
    else
      render 'new'
    end
  end

  def update

  end

  def set_user  # duplicate // should be centralized
    @user = current_user
  end

  private
    def build_reservation(reserv)

      arrival = Date.new reserv["start_date(1i)",].to_i, reserv["start_date(2i)",].to_i, reserv["start_date(3i)",].to_i
      depart = Date.new reserv["end_date(1i)",].to_i, reserv["end_date(2i)",].to_i, reserv["end_date(3i)",].to_i
      demands = reserv["client_demands"]

      current_user.reservations.build({start_date: arrival, end_date: depart, client_demands: demands})
    end
end
