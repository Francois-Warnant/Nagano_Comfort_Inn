class Gestion::ReservationsController < ApplicationController
  load_and_authorize_resource

  def index
    @reservation = Reservation.all
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

  private 
    def build_params(params)
      params_reservation= params[:reservation]
      id = User.find_by_email(params_reservation[:user_id]).id
      
      params_reservation[:user_id] = id
      
      return params_reservation
    end
end
