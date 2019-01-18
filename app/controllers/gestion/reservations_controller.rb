class Gestion::ReservationsController < ApplicationController
  load_and_authorize_resource

  def index
    @reservation = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    params_reservation= params[:reservation]
    mail = params_reservation[:user_id]      ##c pas beau... à changer
    id = User.find_by_email(mail)
    params_reservation[:user_id] = id



    @reservation = Reservation.create(params_reservation)


    if @reservation.save
      flash[:success] = "NEW RESERVATION ADDED"

      redirect_to gestion_reservations_path
    else
      render 'new'
    end
  end
end
