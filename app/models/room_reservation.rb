# == Schema Information
#
# Table name: room_reservations
#
#  id             :integer          not null, primary key
#  reservation_id :integer
#  room_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_date     :datetime
#  end_date       :datetime
#

class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :room_id, :start_date, :end_date

  belongs_to :reservation
  belongs_to :room

  # Sélectionne les réservations selon la start_date.
  scope :after_start_date, lambda { |date| where ('start_date < ?'), date }
  scope :before_start_date, lambda { |date| where ('start_date > ?'), date } # regarder nombre de jours entre et analyser si assez pour location

  # Sélectionne les réservations selon la end_date.
  scope :after_end_date, lambda { |date| where ('end_date < ?'), date }
  scope :before_end_date, lambda { |date| where ('end_date > ?'), date }
end
