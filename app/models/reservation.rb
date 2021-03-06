# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  client_demands :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  nb_rooms       :integer
#

class Reservation < ActiveRecord::Base
  attr_accessible :client_demands, :nb_rooms, :user_id

  belongs_to :user
  has_many :room_reservations, dependent: :destroy
  has_many :rooms, through: :room_reservations

  validates :user_id, presence: true

  default_scope order: 'reservations.id DESC'


  def reserve_room!(room)
    room_reservations.create!(room_id: room.id)
  end

end
