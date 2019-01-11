# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  view_id    :integer
#  floor_no   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_no    :integer
#

class Room < ActiveRecord::Base
  attr_accessible :floor_no, :type_id, :view_id, :room_no

  has_many :user, through: :reservations

end
