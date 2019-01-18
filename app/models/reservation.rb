# == Schema Information
#
# Table name: reservations
#
#  id             :integer          not null, primary key
#  start_date     :datetime
#  end_date       :datetime
#  client_demands :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#

class Reservation < ActiveRecord::Base
  attr_accessible :client_demands, :end_date, :start_date, :user_id

  belongs_to :user
  has_many :room_reservations, dependent: :destroy
  has_many :rooms, through: :room_reservations

  validates :user_id, presence: true




  def reserve_room!(room)
    room_reservations.create!(room_id: room.id)
  end

end
