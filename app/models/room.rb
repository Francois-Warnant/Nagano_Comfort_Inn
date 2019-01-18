# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  floor_no   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_no    :integer
#

class Room < ActiveRecord::Base
  attr_accessible :floor_no, :room_no, :room_type_id, :view_type_id

  has_many :room_reservations
  has_many :reservations, through: :room_reservations

  def assign_room_type!(new_room_type)
    self.room_type_id = new_room_type
  end

  def assign_view_type!(new_view_type)
    self.room_type_id = new_view_type
  end
end
